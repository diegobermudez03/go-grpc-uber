package models

import (
	"errors"
	"sync"
)

var (
	ErrUserAlreadyRegistered = errors.New("USER_ALREADY_REGISTERED")
	ErrUnahtorized = errors.New("USER_UNATHORIZED_OR_INVALID")
)

type ClientModel struct {
	Name   string
	Number int64
}

type UberServiceTypeModel struct{
	Name 		string 
	HourPrice	float64 
	Description string
}

type UberTaxiModel struct{
	Placa 		string 
	ServiceType string 
	Bot			bool
	Occupied	bool
	Position 	*PositionModel
	Lock		sync.RWMutex
	ComChannel  chan RequestMessage
}

type PositionModel struct{
	X	int 
	Y 	int
}

type ChannelMessage struct{
	Asking bool
	Found bool
	Denied bool 
	Price float64
	Position PositionModel
	Placa string
	Distance float64
}

type RequestMessage struct{
	Client ClientModel
	Distance float64
	Position PositionModel
}