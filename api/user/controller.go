package user

import (
	"api/reminders"
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
)

var (
	userService     = new(Service)
	reminderService = reminders.NewService(reminders.NewRepository())
)

func LoginHandler(w http.ResponseWriter, r *http.Request) {

	username := r.Header.Get("Username")
	password := r.Header.Get("Password")

	user := userService.GetUser(username)
	w.Header().Set("Access-Control-Allow-Origin", "*")
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

func CreateReminder(w http.ResponseWriter, r *http.Request) {

	var reminder reminders.Reminder
	bodyBytes, _ := ioutil.ReadAll(r.Body)
	var jsonBody string = string(bodyBytes)
	err := json.Unmarshal(bodyBytes, &reminder)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed parsing request body. Body was %s", jsonBody)
		return
	}

	err = reminderService.AddReminder(reminder)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Printf("ERROR: Failed adding reminder %s ", err.Error())
		return
	}

}

func DeleteReminder(w http.ResponseWriter, r *http.Request) {

	vars := mux.Vars(r)
	//username := vars["user"]
	reminderId := vars["reminder"]
	val, err := strconv.Atoi(reminderId)

	err = reminderService.DeleteReminder(val)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed parsing request body")
		return
	}

}

func UpdateReminder(w http.ResponseWriter, r *http.Request) {
	log.Println("updating reminder")

	bodyBytes, _ := ioutil.ReadAll(r.Body)

	var reminder reminders.Reminder
	err := json.Unmarshal(bodyBytes, &reminder)
	var jsonBody string = string(bodyBytes)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed parsing request body")
		return
	}

	if reminder.Id == 0 {
		http.Error(w, "missing or invalid reminderId", http.StatusBadRequest)
		log.Printf("missing or invalid reminderId. Request body was %s", jsonBody)
		return
	}

	err = reminderService.UpdateReminder(reminder)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Printf("ERROR: Failed updating reminder: %s", err.Error())
		return
	}
	log.Println("Updated reminder successfully")

}

func GetReminders(w http.ResponseWriter, r *http.Request) {

	var resp reminders.GetRemindersResponse

	vars := mux.Vars(r)
	username := vars["user"]

	remindersList, err := reminderService.GetReminders(username)
	resp.Reminders = remindersList

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println("ERROR: Failed parsing request body")
		return
	}

	err = json.NewEncoder(w).Encode(&resp)

	if err != nil {
		http.Error(w, fmt.Sprintf("Some issue with server: %s", err.Error()), http.StatusInternalServerError)
		return
	}

}
