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
	clientgrpc.UnimplementedClientServiceServer
}

func NewClientService() clientgrpc.ClientServiceServer{
	return &ClientService{
		registeredClients: map[string]*models.ClientModel{},
		clientsLock: sync.RWMutex{},
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
	return nil, nil 
}


//for requesting the uber ride, server streaming message -> stream
//client sends ride request, server sends live updates of process of getting an uber
func (s *ClientService) RequestUber(request *clientgrpc.UberRequestDTO, stream clientgrpc.ClientService_RequestUberServer) error{
	return nil
}