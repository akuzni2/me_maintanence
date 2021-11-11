package main

import (
	"api/user"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
)

func main() {

	r := mux.NewRouter()

	r.HandleFunc("/api/login", user.LoginHandler).Methods("GET")
	r.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		log.Println("Up and running!")
	})

	var port = os.Getenv("PORT")

	log.Printf("Starting application on port %s\n", port)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), r))

}
