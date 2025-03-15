package models

import "errors"

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