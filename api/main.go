package main

import (
	"api/preventative_care"
	"api/user"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Llongfile)
	r := mux.NewRouter()

	r.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		log.Println("Up and running!")
	})

	r.HandleFunc("/api/login", user.LoginHandler).Methods("GET")
	r.HandleFunc("/api/recommendations", preventative_care.RecommendationHandler).Methods("GET")

	var port = os.Getenv("PORT")

	log.Printf("Starting application on port %s\n", port)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), r))

}
