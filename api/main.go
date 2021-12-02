package main

import (
	"api/preventative_care"
	"api/user"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/rs/cors"
	"log"
	"net/http"
	"os"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Llongfile)

	main1()

}

func main1() {
	router := mux.NewRouter()

	// Where ORIGIN_ALLOWED is like `scheme://dns[:port]`, or `*` (insecure)

	headersOk := handlers.AllowedHeaders([]string{"X-Requested-With", "Content-Type", "Authorization", "username", "password"})
	methodsOk := handlers.AllowedMethods([]string{"GET", "HEAD", "POST", "PUT", "OPTIONS"})
	originsOk := handlers.AllowedOrigins([]string{"*"})

	router.HandleFunc("/hello", func(writer http.ResponseWriter, request *http.Request) {
		log.Println("Up and running from main 1!")
	})

	router.HandleFunc("/api/login", user.LoginHandler)

	router.HandleFunc("/api/user/{user}/reminders", user.GetReminders).Methods("GET")
	router.HandleFunc("/api/user/{user}/reminders", user.UpdateReminder).Methods("PUT")
	router.HandleFunc("/api/user/{user}/reminders", user.CreateReminder).Methods("POST")
	router.HandleFunc("/api/user/{user}/reminders/{reminder}", user.DeleteReminder).Methods("DELETE")

	router.HandleFunc("/api/recommendations", preventative_care.RecommendationHandler).Methods("GET")

	var port = os.Getenv("PORT")

	log.Printf("Starting application on port %s\n", port)

	//log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), router))
	log.Fatal(http.ListenAndServe(":"+os.Getenv("PORT"), handlers.CORS(originsOk, headersOk, methodsOk)(router)))

}

func main2() {

	http.HandleFunc("/hello", func(writer http.ResponseWriter, request *http.Request) {
		log.Println("Up and running!")
	})

	http.HandleFunc("/api/login", user.LoginHandler)

	err := http.ListenAndServe(":"+os.Getenv("PORT"), nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func main3() {
	mux := http.NewServeMux()

	mux.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte("{\"hello\": \"world from hello function\"}"))
	})

	mux.HandleFunc("/api/login", user.LoginHandler)

	c := cors.New(cors.Options{
		AllowedOrigins:   []string{"*"},
		AllowCredentials: true,
		AllowedHeaders:   []string{"username", "password"},
		AllowedMethods:   []string{"GET", "HEAD", "POST", "PUT", "OPTIONS"},
		// Enable Debugging for testing, consider disabling in production
		Debug: true,
	})

	handler := c.Handler(mux)

	http.ListenAndServe(":"+os.Getenv("PORT"), handler)
}
