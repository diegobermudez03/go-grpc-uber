package services

import (
	"context"
	"log"
	"math"
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
		registeredTaxis: getInitialTaxis(),
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
		Lock: sync.RWMutex{},
		Bot: false,
		Occupied: false,
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
	update, err := stream.Recv()
	if err != nil{
		log.Println("Error STABLISHING location connection")
		return nil
	}
	if _, ok := s.registeredTaxis[update.Placa]; !ok{
		log.Printf("Unregistered taxi %s tried to send update", update.Placa)
		return models.ErrUnahtorized
	}
	//critic zone, but is only reading locking
	s.taxisLock.RLock()
	taxi := s.registeredTaxis[update.Placa]
	s.taxisLock.RUnlock()
	for{
		if update.Position.XPosition == 0 || update.Position.YPosition == 0{
			log.Printf("Taxi of placa %s terminated its connection", update.Placa)
			//removing the taxi, critic zone, so using mutex
			s.taxisLock.Lock()
			delete(s.registeredTaxis, update.Placa)
			s.taxisLock.Unlock()
			break
		}

		//only this taxi critic zone, its position
		taxi.Lock.Lock()
		if taxi.Position == nil{
			taxi.Position = new(models.PositionModel)
		}
		taxi.Position.X = int(update.Position.XPosition)
		taxi.Position.Y = int(update.Position.YPosition)
		taxi.Lock.Unlock()

		log.Printf("updated position of %s (%d, %d)",update.Placa, taxi.Position.X, taxi.Position.Y)
		update, err = stream.Recv()
		if err != nil{
			taxi.Position = nil
			log.Printf("Taxi %s disconnected location update", taxi.Placa)
			return nil
		}
	}
	return nil
}

//for live updateing of ride requests, bidirectional streaming stream -> stream
//server sends ride requests, uber sends if he accpets or denies the service
func (s *UberService) GetRequests(stream ubergrpc.UberService_GetRequestsServer) error{
	req, err := stream.Recv()
	if err != nil{
		log.Printf("Error with uber trying to connect to requests %v", err)
		return err 
	}
	//if the taxi is not registered then F
	taxi, ok:= s.registeredTaxis[req.Placa]
	if !ok{
		return models.ErrUnahtorized
	}
	log.Printf("Uber %s connected to get requests", req.Placa)
	//we create and set the channel
	newComChannel := make(chan models.RequestMessage)
	taxi.ComChannel = newComChannel

	//now we simply start listening on this channel for any incoming requests
	uberIsThere := stream.Context().Done()
	for{
		select{
		case <- uberIsThere: close(taxi.ComChannel); taxi.ComChannel = nil; return nil 
		case message := <- newComChannel:{
			stream.Send(&ubergrpc.RequestsUpdates{
				ClientName: message.Client.Name,
				ClientPsoition: &ubergrpc.Position{
					XPosition: uint32(message.Position.X),
					YPosition: uint32(message.Position.Y),
				},
				Distance: message.Distance,
			})
			//now wait for the taxi answer
			answer, err := stream.Recv()
			if err != nil{
				break
			}
			if answer.Accepted{
				//if we do accept it, then we send a message indicating that in the channel and we set ourselves as occupied
				newComChannel <- models.RequestMessage{}
				taxi.Occupied = true
			}else{
				//if not acepted then we send a message in our channel indicating that
				newComChannel <- models.RequestMessage{Distance: -1}
			}
		}
		}
	}
}

//function that uses the Client service to request an uber for a request to this the uber service
func (s *UberService) ClientRequestUber(clientX, clientY int, client models.ClientModel,channel chan models.ChannelMessage){
	toAvoid := map[string]bool{}
	position := models.PositionModel{
		X: clientX,
		Y: clientY,
	}
	for{
		bot, dBot, real, dReal := s.getClosestTaxi(clientX, clientY, toAvoid)
		if real != nil{
			log.Printf("Asking taxi %s for ride of %s", real.Placa, client.Name)
			//we send the message to the client that we are asking
			channel <- models.ChannelMessage{
				Asking: true,
				Position: *real.Position,
				Price: s.ServiceTypes[real.ServiceType].HourPrice,
				Placa: real.Placa,
				Distance: dReal,
			}
			//we ask the taxi
			real.ComChannel <- models.RequestMessage{
				Client: client,
				Distance: dReal,
				Position: position,
			}

			//we wait for taxi answer
			answer :=<- real.ComChannel

			//if uber denied, then we send the message to client indicating that
			if answer.Distance == -1{
				log.Printf("Taxi %s denied ride of %s", real.Placa, client.Name)
				toAvoid[real.Placa] = true
				channel <- models.ChannelMessage{
					Denied: true,
					Placa: real.Placa,
				}
			}else{	//if uber accepted, then we send the message and close everything
				log.Printf("Taxi %s Accepted ride of %s", real.Placa, client.Name)
				channel <- models.ChannelMessage{
					Found: true,
					Position: *real.Position,
					Price: s.ServiceTypes[real.ServiceType].HourPrice,
					Placa: real.Placa,
					Distance: dReal,
				}
				close(channel)
				return
			}
		}else{ //if the closest taxi was not real but a Bot, then we simply send the info to the client and update occupied
			log.Printf("Taxi %s Accepted ride of %s", bot.Placa, client.Name)
			channel <- models.ChannelMessage{
				Found: true,
				Position: *bot.Position,
				Price: s.ServiceTypes[bot.ServiceType].HourPrice,
				Placa: bot.Placa,
				Distance: dBot,
			}
			close(channel)
			bot.Occupied = true
			return
		}
	}
}

//proivate method to get the closest taxi to the client (avoiding the ones that already denied)
func (s *UberService) getClosestTaxi(clientX, clientY int, toAvoid map[string]bool) (*models.UberTaxiModel, float64, *models.UberTaxiModel, float64){
	var closestDistaneBot float64 = -1
	var closestDistanceReal float64 = -1
	var closestBot *models.UberTaxiModel
	var closestReal *models.UberTaxiModel
	for _, taxi := range s.registeredTaxis{
		//if the taxi isin the toavoid set, means that we already asked him and denied, so we avoid
		//or also, if the taxi is occupied, then we avoid it
		if _, ok := toAvoid[taxi.Placa]; ok || taxi.Occupied || taxi.Position == nil{
			continue
		}
		//critic zone of taxi position, so we use the lock
		taxi.Lock.RLock()
		distance := math.Abs(float64(clientX)-float64(taxi.Position.X)) + math.Abs(float64(clientY)-float64(taxi.Position.Y))
		taxi.Lock.RUnlock()

		if taxi.Bot{
			if closestDistaneBot == -1 || distance < float64(closestDistaneBot){
				closestDistaneBot = distance
				closestBot = taxi
			}
		}else{
			if closestDistanceReal == -1 || distance < float64(closestDistanceReal){
				closestDistanceReal = distance
				closestReal = taxi
			}
		}
	}
	//we return the 2 closest found
	return closestBot,closestDistaneBot , closestReal, closestDistanceReal
}

//hardcoded service types
func getServiceTypes()map[string]models.UberServiceTypeModel{
	return map[string]models.UberServiceTypeModel{
		"Normal" : {Name: "Normal", HourPrice: 50000, Description: "Taxis amarillos"},
		"Express" : {Name: "Express", HourPrice:  70000, Description: "Taxis mas amplios y comodos"},
		"Excursion" : {Name: "Excursion", HourPrice:  120000, Description: "Te llevan a cualquier lugar y te esperan"},
	}
}

//hardcoded initial bot taxis
func getInitialTaxis()map[string]*models.UberTaxiModel{
	return map[string]*models.UberTaxiModel{
		"XXC23": {Placa: "XXC23", ServiceType: "Normal", Position: &models.PositionModel{X: 1, Y: 1}, Bot: true, Occupied: false},
		"XCV33": {Placa: "XCV33", ServiceType: "Normal", Position: &models.PositionModel{X: 5, Y: 4}, Bot: true, Occupied: false},
		"GHJ45": {Placa: "GHJ45", ServiceType: "Normal", Position: &models.PositionModel{X: 6, Y: 9}, Bot: true, Occupied: false},
		"RR167": {Placa: "RR167", ServiceType: "Normal", Position: &models.PositionModel{X: 3, Y: 8}, Bot: true, Occupied: false},
		"GGT55": {Placa: "GGT55", ServiceType: "Normal", Position: &models.PositionModel{X: 4, Y: 4}, Bot: true, Occupied: false},
		"HHW33": {Placa: "HHW33", ServiceType: "Normal", Position: &models.PositionModel{X: 2, Y: 3}, Bot: true, Occupied: false},
	}
}