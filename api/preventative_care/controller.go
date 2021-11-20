package preventative_care

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
)

var (
	service = NewService(NewRepository())
)

func RecommendationHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Content-Type", "application/json")

	var req RecommendedPreventativeCareItemRequest


	var age string = r.URL.Query().Get("age")
	var gender string = r.URL.Query().Get("gender")

	if age == "" || gender == "" {
		http.Error(w, "Input parameters were incorrect", http.StatusBadRequest)
		return
	}

	req.Gender = gender
	ageint, err := strconv.Atoi(age)

	req.Age = ageint

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed parsing age to integer in request")
		return
	}

	res, err := service.GetRecommendedCareItems(req)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed calling recommender service")
		return
	}

	err = json.NewEncoder(w).Encode(&res)
	if err != nil {
		http.Error(w, fmt.Sprintf("SOme issue with server: %s", err.Error()), http.StatusInternalServerError)
		return
	}

}
