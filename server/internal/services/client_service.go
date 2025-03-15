package services

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"log"
	"sync"

	"github.com/diegobermudez03/uber-server/grpc_api/gen/clientgrpc"
	"github.com/diegobermudez03/uber-server/internal/models"
)

type ClientService struct {
	registeredClients	map[string]*models.ClientModel
	clientsLock 		sync.RWMutex

	uberServicTypes 	[]models.UberServiceTypeModel
	clientgrpc.UnimplementedClientServiceServer
}

func NewClientService() clientgrpc.ClientServiceServer{
	return &ClientService{
		registeredClients: map[string]*models.ClientModel{},
		clientsLock: sync.RWMutex{},
		uberServicTypes: getServiceTypes(),
	}
}

//register method, unary message -> message.
//client sends request, server sends session token
func (s *ClientService) ClientRegister(ctx context.Context, dto *clientgrpc.ClientRegisterDTO) (*clientgrpc.SessionToken, error){
	//generate session token
	bytes := make([]byte, 64)
    rand.Read(bytes)
	token := hex.EncodeToString(bytes)

	//save new client, using lock for critic zone
	s.clientsLock.Lock()
	s.registeredClients[token] = &models.ClientModel{
		Name: dto.Name,
		Number: int64(dto.Number),
	}
	s.clientsLock.Unlock()
	
	log.Printf("New client registered %s\n", dto.Name)
	//returning generated token
	return &clientgrpc.SessionToken{
		Token: token,
	}, nil
}

//for retrieving the service types, unary message -> message
//client sends session token (to confirm its authenticated), server sends service types
func(s *ClientService) GetServiceTypes(ctx context.Context, token *clientgrpc.SessionToken) (*clientgrpc.ListServiceTypes, error){
	//veryfying that user is indeed registered
	if _, ok := s.registeredClients[token.Token]; !ok{
		log.Printf("Client %v attempted to access unathorized", token.Token)
		return nil, models.ErrUnahtorized
	}

	//if user was authorized then returning the service types, for this we need
	//to map the internal model type to the grpc model type
	returnDtos := make([]*clientgrpc.ServiceType,0 ,len(s.uberServicTypes))
	for _, sType := range s.uberServicTypes{
		returnDtos = append(returnDtos, &clientgrpc.ServiceType{
			Name: sType.Name,
			HourPrice: sType.HourPrice,
			Description: sType.Description,
		})
	}

	log.Printf("Service types requested and returned succesfully")
	return &clientgrpc.ListServiceTypes{
		Types: returnDtos,
	}, nil 
}


//for requesting the uber ride, server streaming message -> stream
//client sends ride request, server sends live updates of process of getting an uber
func (s *ClientService) RequestUber(request *clientgrpc.UberRequestDTO, stream clientgrpc.ClientService_RequestUberServer) error{
	return nil
}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////						PRIVATE METHODS										///////////////////////////////////

func getServiceTypes()[]models.UberServiceTypeModel{
	return []models.UberServiceTypeModel{
		{Name: "Normal", HourPrice: 50000, Description: "Taxis amarillos"},
		{Name: "Express", HourPrice:  70000, Description: "Taxis mas amplios y comodos"},
		{Name: "Excursion", HourPrice:  120000, Description: "Te llevan a cualquier lugar y te esperan"},
	}
}