package models

type Message struct {
	Status	string	`json:"status"`
	Message	string	`json:"message"`
}

type Signin struct {
	Token	string	`json:"access_token"`
	User	*User	`json:"current_user"`
}
