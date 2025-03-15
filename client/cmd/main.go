package main

import (
	"log"
	"os"

	clientgrpc "github.com/diegobermudez03/uber-client/grpc_api/gen"
	"github.com/diegobermudez03/uber-client/internal"
	"github.com/tcnksm/go-input"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	var conn *grpc.ClientConn
	conn, err := grpc.NewClient(":9000", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil{
		log.Fatalf("couldnt connect: %s", err)
	}
	defer conn.Close()

	//creating grpc client
	client := clientgrpc.NewClientServiceClient(conn)

	ui := &input.UI{Writer: os.Stdout, Reader : os.Stdin}

	//creating service, injecting grpc client, and letting it do the rest of the work
	service := internal.NewClientService(client, ui)
	service.Register()
}