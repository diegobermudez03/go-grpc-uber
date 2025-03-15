package models

import "errors"

var (
	ErrUserAlreadyRegistered = errors.New("USER_ALREADY_REGISTERED")
)

type ClientModel struct {
	Name   string
	Number int64
}