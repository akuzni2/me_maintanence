package user

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

var (
	s = new(Service)
)

type Service struct {
	repository *MysqlUserRepository
}

type User struct {
	Username            string `json:"username,omitempty"`
	Password            string `json:"password,omitempty"`
	Phone_numer         string `json:"phone_number,omitempty"`
	Fhir_server_address string `json:"fhir_server_address,omitempty"`
	Patient_id          string `json:"patient_id,omitempty"`
}

func (s *Service) GetUser(username string) *User {
	log.Println("Getting user ", username)
	var user, err = s.repository.GetUser(username)
	if err != nil {
		fmt.Println("Do someting with this error:", err)
	}

	return user

}

func LoginHandler(w http.ResponseWriter, r *http.Request) {

	username := r.Header.Get("Username")
	password := r.Header.Get("Password")

	user := s.GetUser(username)

	w.Header().Set("Content-Type", "application/json")

	if user.Password != password {
		log.Println("Wrong Password")
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte("Incorrect Password"))
	} else {
		log.Println("got user: ", user)
		json.NewEncoder(w).Encode(&user)
	}

}
