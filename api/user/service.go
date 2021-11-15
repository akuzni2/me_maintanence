package user

import (
	"fmt"
	"log"
)

// TODO refactor this service to be like whats in the `preventative_care` package
type Service struct {
	repository *MysqlUserRepository
}

func (s *Service) GetUser(username string) *User {
	log.Println("Getting user ", username)
	var user, err = s.repository.GetUser(username)
	if err != nil {
		fmt.Println("Do someting with this error:", err)
	}

	return user

}
