package services

import (
	"context"

	"github.com/diegobermudez03/uber-server/grpc_api/gen/ubergrpc"
)

type UberService struct {
	ubergrpc.UnimplementedUberServiceServer
}

func NewUberService() ubergrpc.UberServiceServer{
	return &UberService{}
}

//for registering as a uber driver, unary message -> message
//client sends register dto with las placas and his service type, server sends ack
func (s *UberService) UberRegister(ctx context.Context, dto *ubergrpc.UberRegisterDTO) (*ubergrpc.Ackonledgment, error){
	return nil, nil 
}

//for live updating uber posittion, client streaming stream -> empty
//client sends live updates of his position, server doesnt respond
func (s *UberService) UpdatePosition(stream ubergrpc.UberService_UpdatePositionServer) error{
	return nil
}

//for live updateing of ride requests, bidirectional streaming stream -> stream
//server sends ride requests, uber sends if he accpets or denies the service
func (s *UberService) GetRequests(stream ubergrpc.UberService_GetRequestsServer) error{
	return nil
}