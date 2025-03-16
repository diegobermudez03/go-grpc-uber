package internal

import (
	"bufio"
	"context"
	"fmt"
	"strconv"
	"strings"

	clientgrpc "github.com/diegobermudez03/uber-client/grpc_api/gen"
)

type ClientService struct {
	grpc 	clientgrpc.ClientServiceClient
	token 	*string
	scanner *bufio.Reader
}

func NewClientService(grpc clientgrpc.ClientServiceClient, scanner *bufio.Reader) *ClientService {
	return &ClientService{
		grpc: grpc,
		scanner: scanner,
	}
}

//register method, the one that asks the user for the name and number
//once registered moves on to the menu 
func (s *ClientService) Register() {
	//asking for user name
	fmt.Printf("Please write your name: ")
	name, _ := s.scanner.ReadString('\n')
	name = strings.TrimSpace(name)

	//asking for user number and vefying it
	var number int64 
	for {
		fmt.Printf("Please write your number: ")
		numberStr, _ := s.scanner.ReadString('\n')
		numberStr = strings.TrimSpace(numberStr)
		var err error
		number, err = strconv.ParseInt(strings.TrimSpace(numberStr), 10, 64)
		if err != nil{
			fmt.Printf("INVALID NUMBER %v\n", err)
			continue
		}
		break
	}

	//sending client register request
	token ,err := s.grpc.ClientRegister(
		context.TODO(), 
		&clientgrpc.ClientRegisterDTO{
			Name:  name,
			Number: uint64(number),
		},
	)
	if err != nil{
		fmt.Printf("UNABLE TO REGISTER %v\n", err)
		return
	}
	s.token = &token.Token
	//if everything was fine then we continue to the menu page
	s.MainMenu()
}


//main menu function, simply allows to move from get service types, request rides, and exit
func(s *ClientService) MainMenu(){
	for{
		fmt.Println("\nSelect an option")
		fmt.Println("1. Get service types")
		fmt.Println("2. Request a ride")
		fmt.Println("3. Exit")
		fmt.Print("Option: ")
		optionStr, _ := s.scanner.ReadString('\n')
		option, err := strconv.Atoi(strings.TrimSpace(optionStr))
		if err != nil{
			fmt.Print("INVALID OPTION")
			continue
		}

		switch option{
		case 1: s.getServiceTypes()
		case 2: s.requestRide()
		case 3: return
		}
	}
}

//function that retrieves the service types from the grpc server
func(s *ClientService) getServiceTypes(){
	//calling remote method
	serviceTypes, err := s.grpc.GetServiceTypes(context.TODO(), &clientgrpc.SessionToken{Token: *s.token})
	if err != nil{
		fmt.Printf("Error retrieving the service types %v\n", err)
		return 
	}
	//iterating over types and printing them
	for _, sType := range serviceTypes.Types{
		fmt.Printf("Tipo: %s     -     Costo: %.2f hora     -     Descripcion: %s\n", sType.Name, sType.HourPrice, sType.Description)
	}
}

//to request a taxi ride
func(s *ClientService) requestRide(){
	fmt.Print("Enter X position: ")
	xPosStr, _ := s.scanner.ReadString('\n')
	fmt.Print("Enter Y position: ")
	yPosStr, _ := s.scanner.ReadString('\n')

	//validate both inputs
	xPos, err := strconv.Atoi(strings.TrimSpace(xPosStr))
	if err != nil || xPos > 10 || xPos < 1{
		fmt.Println("INVALID POSITION")
		return 
	}
	yPos, err := strconv.Atoi(strings.TrimSpace(yPosStr))
	if err != nil || yPos > 10 || yPos < 1{
		fmt.Println("INVALID POSITION")
		return 
	}

	//if both inputs are correct then connect to server
	connection, err := s.grpc.RequestUber(context.TODO(), &clientgrpc.UberRequestDTO{
		Token : *s.token,
		Position: &clientgrpc.Position{
			XPosition: uint32(xPos),
			YPosition: uint32(yPos),
		},
	})
	if err != nil{
		fmt.Println("Error requesting ride", err)
		return
	}

	//listen for updates on the connection
	for{
		requestUpdate, err := connection.Recv()
		if err != nil{
			fmt.Println("Error with ride request", err)
			return 
		}
		asked := requestUpdate.GetAsked()
		denied := requestUpdate.GetDenied()
		selected := requestUpdate.GetSelected()
		//checking different messages types, any requested, denied or accepted
		if asked != nil{
			fmt.Printf("\nServer is asking to uber %s", asked.Placa)
		}else if denied != nil{
			fmt.Printf("\nUber %s denied the request, searching for more taxis", denied.Placa)
		}else if selected != nil{
			fmt.Printf("\nUber %s accepted the ride, is at location (%d, %d), total distance: %.2f, price: %.2f", 
			selected.Placa, 
			selected.UberPosition.XPosition, 
			selected.UberPosition.YPosition, 
			selected.Distance,
			selected.Price,
			)
			fmt.Println("\nEnter something whenever you want to go back to the menu: ")
			s.scanner.ReadString('\n')
			return
		}
	}

}