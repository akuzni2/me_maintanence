package user

import (
	"encoding/json"
	"log"
	"net/http"
)

var (
	s = new(Service)
)

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
