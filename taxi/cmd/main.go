package main

import (
	"bufio"
	"log"
	"os"

	ubergrpc "github.com/diegobermudez03/uber-taxi/grpc_api/gen"
	"github.com/diegobermudez03/uber-taxi/internal"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	var conn *grpc.ClientConn
	conn, err := grpc.NewClient(":9000", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil{
		log.Fatalf("couldnt connect: %v", err)
	}
	defer conn.Close()

	//creating grpc client
	client := ubergrpc.NewUberServiceClient(conn)

	scanner := bufio.NewReader(os.Stdin)
	
	//creating service and injecting grpc dependencies
	service := internal.NewUberService(client, scanner)
	service.Register()
}