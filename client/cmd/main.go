package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"

	clientgrpc "github.com/diegobermudez03/uber-client/grpc_api/gen"
	"github.com/diegobermudez03/uber-client/internal"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	scanner := bufio.NewReader(os.Stdin)
	fmt.Println("Enter the server IP:Port (if ommited then default 127.0.0.1:9000): ")
	address, _ := scanner.ReadString('\n');
	if strings.TrimSpace(address) == ""{
		address = ":9000"
	}
	var conn *grpc.ClientConn
	conn, err := grpc.NewClient(address, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil{
		log.Fatalf("couldnt connect: %v", err)
	}
	defer conn.Close()

	//creating grpc client
	client := clientgrpc.NewClientServiceClient(conn)

	//creating service, injecting grpc client, and letting it do the rest of the work
	service := internal.NewClientService(client, scanner)
	service.Register()
}