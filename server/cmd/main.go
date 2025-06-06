package main

import (
	"log"
	"net"

	"github.com/diegobermudez03/uber-server/grpc_api/gen/clientgrpc"
	"github.com/diegobermudez03/uber-server/grpc_api/gen/ubergrpc"
	"github.com/diegobermudez03/uber-server/internal/services"
	"google.golang.org/grpc"
)

//entry point of the server app
func main() {
	lis, err := net.Listen("tcp", ":9000")
	if err != nil{
		log.Fatalf("Failed to listen on port 9000 %v", err)
	}

	//main grpc server
	grpcServer := grpc.NewServer()

	//creating services to suscribe to grpc
	uberService := services.NewUberService()
	clientService := services.NewClientService(uberService.(*services.UberService))

	//suscribing both services to the grpc server
	clientgrpc.RegisterClientServiceServer(grpcServer, clientService)
	ubergrpc.RegisterUberServiceServer(grpcServer, uberService)
	
	log.Print("Listening on port :9000")
	//starting grpc server to listen on port 9000
	if err := grpcServer.Serve(lis); err != nil{
		log.Fatalf("Failed to serve GRPC server over port :9000 %v", err)
	}
}