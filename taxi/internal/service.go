package internal

import (
	"bufio"
	"context"
	"fmt"
	"strconv"
	"strings"

	ubergrpc "github.com/diegobermudez03/uber-taxi/grpc_api/gen"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
)

type UberService struct {
	scanner 	*bufio.Reader
	placa 		string
	grpc 		ubergrpc.UberServiceClient
}

func NewUberService(grpc ubergrpc.UberServiceClient, scanner *bufio.Reader) *UberService{
	return &UberService{
		scanner: scanner,
		grpc: grpc,
	}
}


func (s *UberService) Register(){
	//asking for the placa of the taxi
	fmt.Printf("Please write your placa: ")
	placa, _ := s.scanner.ReadString('\n')
	placa = strings.TrimSpace(placa)

	//please enter your taxi type
	fmt.Printf("Please write your service type: ")
	serviceType, _ := s.scanner.ReadString('\n')
	serviceType = strings.TrimSpace(serviceType)

	ack, err := s.grpc.UberRegister(context.TODO(), &ubergrpc.UberRegisterDTO{
		Placa: placa,
		ServiceType: serviceType,
	})
	if err != nil || !ack.Registered{
		fmt.Println("ERROR REGISTERING")
		return 
	}
	s.placa = placa
	fmt.Println("Succesfully registered")
	
	//once registered we move on to the main uber page, thta uber page will receive 2 
	s.MainPageUber()
}

func (s *UberService) MainPageUber(){

}


func (s *UberService) LocationUpdates(){
	fmt.Print("Enter initial X position: ")
	xPosStr, _ := s.scanner.ReadString('\n')
	fmt.Print("Enter initial Y position: ")
	yPosStr, _ := s.scanner.ReadString('\n')

	//validate both inputs
	xPos, err := strconv.Atoi(strings.TrimSpace(xPosStr))
	if err != nil{
		fmt.Println("INVALID INITIAL POSITION")
		return 
	}
	yPos, err := strconv.Atoi(strings.TrimSpace(yPosStr))
	if err != nil{
		fmt.Println("INVALID INITIAL POSITION")
		return 
	}

	connection, err := s.grpc.UpdatePosition(context.TODO())
	if err != nil{
		fmt.Println("ERROR SENDING LOCATION UPDATES")
		return 
	}

	//sending initial position
	connection.Send(&ubergrpc.PositionUpdate{
		Placa: s.placa,
		Position: &ubergrpc.Position{
			YPosition: uint32(yPos),
			XPosition: uint32(xPos),
		},
	})

	fmt.Println("From now on, you can update your location by moving.")
	fmt.Println("'R' = 1 move right")
	fmt.Println("'L' = 1 move left")
	fmt.Println("'T' = 1 move top")
	fmt.Println("'B' = 1 move bottom")
	fmt.Println("'E' = Exit")
	//loop 
	for{
		input, _ := s.scanner.ReadString('\n')
		input = strings.TrimSpace(input)
		switch input{
		case "R" : xPos, yPos = s.updatePosition(xPos+1, yPos, connection)
		case "L" : xPos, yPos = s.updatePosition(xPos-1, yPos, connection)
		case "T" : xPos, yPos = s.updatePosition(xPos, yPos+1, connection)
		case "B" : xPos, yPos = s.updatePosition(xPos, yPos-1, connection)
		case "E" : s.sendFinalMessage(connection); return
		}
		fmt.Printf("Current position: (%d, %d)\n", xPos, yPos)
	}
}

func (s *UberService)  updatePosition(xPos int, yPos int, conn grpc.ClientStreamingClient[ubergrpc.PositionUpdate, emptypb.Empty]) (int, int){
	if xPos > 10{
		xPos -= 1
		fmt.Println("INVALID POSITION")
	}else if xPos < 1{
		xPos += 1
		fmt.Println("INVALID POSITION")
	}else if yPos > 10{
		yPos -= 1
		fmt.Println("INVALID POSITION")
	}else if yPos < 1{
		yPos += 1
		fmt.Println("INVALID POSITION")
	}else{
		conn.Send(&ubergrpc.PositionUpdate{
			Placa: s.placa,
			Position: &ubergrpc.Position{
				YPosition: uint32(yPos),
				XPosition: uint32(xPos),
			},
		})
	}
	return xPos, yPos
}

func (s *UberService) sendFinalMessage(conn grpc.ClientStreamingClient[ubergrpc.PositionUpdate, emptypb.Empty]){
	conn.Send(&ubergrpc.PositionUpdate{
		Placa: s.placa,
		Position: &ubergrpc.Position{
			YPosition: uint32(0),
			XPosition: uint32(0),
		},
	})
}