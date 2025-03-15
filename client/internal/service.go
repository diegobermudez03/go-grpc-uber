package internal

import (
	"context"
	"fmt"
	"strconv"
	"strings"

	clientgrpc "github.com/diegobermudez03/uber-client/grpc_api/gen"
	"github.com/tcnksm/go-input"
)

type ClientService struct {
	grpc 	clientgrpc.ClientServiceClient
	token 	*string
	ui 		*input.UI
}

func NewClientService(grpc clientgrpc.ClientServiceClient, ui *input.UI) *ClientService {
	return &ClientService{
		grpc: grpc,
		ui: ui,
	}
}

//register method, the one that asks the user for the name and number
//once registered moves on to the menu 
func (s *ClientService) Register() {
	//asking for user name
	name, _ := s.ui.Ask("Please write your name", &input.Options{Required: true})

	//asking for user number and vefying it
	var number int64 
	for {
		numberStr, _ := s.ui.Ask("Please write your number", &input.Options{Required: true})
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

func(s *ClientService) MainMenu(){
	fmt.Printf("select")
}