package reminders

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"strconv"
)

type Repository interface {
	Add(reminder Reminder) (Reminder, error)
	Update(reminder Reminder) error
	GetAll(username string) ([]Reminder, error)
	Delete(reminderId int) error
}

type mysqlRepository struct {
	Conn *sql.DB
}

func (m mysqlRepository) Add(reminder Reminder) (Reminder, error) {
	db, err := sql.Open("postgres", psqlInfo)
	checkConnErr(err)
	log.Println("Inserting into reminders table")
	var cols = "(preventative_care_id, username, next_reminder_date_epoch)"
	var values = "($1, $2, $3)"
	var query = fmt.Sprintf("INSERT INTO %s %s VALUES %s RETURNING id", remindersTable, cols, values)

	lid := 0
	err = db.QueryRow(query, reminder.PreventativeCareId, reminder.Username, reminder.ReminderDateEpoch).Scan(&lid)

	reminder.Id = int(lid)

	return reminder, err

}

func (m mysqlRepository) Update(reminder Reminder) error {
	db, err := sql.Open("postgres", psqlInfo)
	checkConnErr(err)

	var query = "UPDATE " + remindersTable + " SET next_reminder_date_epoch = $1 "
	query += "WHERE id = " + strconv.Itoa(reminder.Id)

	_, err = db.Exec(query, reminder.ReminderDateEpoch)

	return err

}

func (m mysqlRepository) GetAll(username string) ([]Reminder, error) {

	var items []Reminder

	db, err := sql.Open("postgres", psqlInfo)
	checkConnErr(err)

	var query = "SELECT id, username, preventative_care_id, next_reminder_date_epoch" +
		" FROM " + remindersTable +
		" WHERE username = $1"

	rows, err := db.Query(query, username)
	defer rows.Close()
	if err != nil {
		log.Println("Issue querying database got error: ", err)
		return nil, err
	}

	for rows.Next() {
		var item Reminder

		err = rows.Scan(&item.Id, &item.Username, &item.PreventativeCareId, &item.ReminderDateEpoch)
		if err = rows.Err(); err != nil {
			log.Println("Issue scanning database got error: ", err)
			return items, err
		}

		items = append(items, item)

	}

	return items, nil

}

func (m mysqlRepository) Delete(reminderId int) error {

	db, err := sql.Open("postgres", psqlInfo)
	checkConnErr(err)

	var query = "DELETE FROM " + remindersTable +
		" WHERE id = $1"

	_, err = db.Exec(query, reminderId)

	return err

}

func NewRepository() Repository {
	return &mysqlRepository{}
}

func checkConnErr(err error) {
	fmt.Println("Checking connection error")
	if err != nil {
		fmt.Println(" Unable to get postgres connection", err)
	}
}

var (
	remindersTable = "reminders"
	port           = 5432
	user           = "main_user"
	dbname         = "me_maintenance_db"
	host           = os.Getenv("DB_HOST")
	password       = os.Getenv("DB_PW")
	psqlInfo       = fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
)
