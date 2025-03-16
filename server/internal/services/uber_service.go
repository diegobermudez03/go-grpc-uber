package services

import (
	"context"
	"log"
	"sync"

	"github.com/diegobermudez03/uber-server/grpc_api/gen/ubergrpc"
	"github.com/diegobermudez03/uber-server/internal/models"
)

type UberService struct {
	ServiceTypes 	map[string]models.UberServiceTypeModel
	registeredTaxis map[string]*models.UberTaxiModel
	taxisLock		sync.RWMutex
	ubergrpc.UnimplementedUberServiceServer
}

func NewUberService() ubergrpc.UberServiceServer{
	return &UberService{
		ServiceTypes: getServiceTypes(),
		registeredTaxis: map[string]*models.UberTaxiModel{},
		taxisLock: sync.RWMutex{},
	}
}

//for registering as a uber driver, unary message -> message
//client sends register dto with las placas and his service type, server sends ack
func (s *UberService) UberRegister(ctx context.Context, dto *ubergrpc.UberRegisterDTO) (*ubergrpc.Ackonledgment, error){
	//validating service type
	serviceType := dto.ServiceType 
	if _, ok := s.ServiceTypes[dto.ServiceType]; !ok{
		serviceType = "Normal"
	}
	//locking for critical zone (registered taxis)
	s.taxisLock.Lock()
	s.registeredTaxis[dto.Placa] = &models.UberTaxiModel{
		Placa: dto.Placa,
		ServiceType: serviceType,
	}
	s.taxisLock.Unlock()
	log.Printf("New taxi with placa %s registered", dto.Placa)
	return &ubergrpc.Ackonledgment{
		Registered: true,
	}, nil 
}

//for live updating uber posittion, client streaming stream -> empty
//client sends live updates of his position, server doesnt respond
func (s *UberService) UpdatePosition(stream ubergrpc.UberService_UpdatePositionServer) error{
	for{
		update, err := stream.Recv()
		if err != nil{
			log.Println("Error with location update")
			break
		}
		if _, ok := s.registeredTaxis[update.Placa]; !ok{
			log.Printf("Unregistered taxi %s tried to send update", update.Placa)
			return models.ErrUnahtorized
		}
		if update.Position.XPosition == 0 || update.Position.YPosition == 0{
			log.Printf("Taxi of placa %s terminated its connection", update.Placa)
			//removing the taxi, critic zone, so using mutex
			s.taxisLock.Lock()
			delete(s.registeredTaxis, update.Placa)
			s.taxisLock.Unlock()
			break
		}
		//critic zone, but is only reading locking
		s.taxisLock.RLock()
		taxi := s.registeredTaxis[update.Placa]
		s.taxisLock.RUnlock()

		if taxi.Position == nil{
			taxi.Position = new(models.PositionModel)
		}
		taxi.Position.X = int(update.Position.XPosition)
		taxi.Position.Y = int(update.Position.YPosition)

		log.Printf("updated position of %s (%d, %d)",update.Placa, taxi.Position.X, taxi.Position.Y)
	}
	return nil
}

//for live updateing of ride requests, bidirectional streaming stream -> stream
//server sends ride requests, uber sends if he accpets or denies the service
func (s *UberService) GetRequests(stream ubergrpc.UberService_GetRequestsServer) error{
	return nil
}


func getServiceTypes()map[string]models.UberServiceTypeModel{
	return map[string]models.UberServiceTypeModel{
		"Normal" : {Name: "Normal", HourPrice: 50000, Description: "Taxis amarillos"},
		"Express" : {Name: "Express", HourPrice:  70000, Description: "Taxis mas amplios y comodos"},
		"Excursion" : {Name: "Excursion", HourPrice:  120000, Description: "Te llevan a cualquier lugar y te esperan"},
	}
}