package services

import (
	"context"

	"github.com/diegobermudez03/uber-server/grpc_api/gen/clientgrpc"
)

type ClientService struct {
	clientgrpc.UnimplementedClientServiceServer
}

func NewClientService() clientgrpc.ClientServiceServer{
	return &ClientService{}
}

//register method, unary message -> message.
//client sends request, server sends session token
func (s *ClientService) ClientRegister(ctx context.Context, dto *clientgrpc.ClientRegisterDTO) (*clientgrpc.SessionToken, error){
	return nil, nil
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