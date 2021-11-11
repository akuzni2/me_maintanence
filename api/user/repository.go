package user

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"log"
	"os"
)

var (
	port     = 5432
	user     = "main_user"
	dbname   = "me_maintenance_db"
	host     = os.Getenv("DB_HOST")
	password = os.Getenv("DB_PW")
	psqlInfo = fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
)

type MysqlUserRepository struct {
	Conn *sql.DB
}

// NewRepository will create an object that represent the Repository interface
func NewMysqlUserRepository(Conn *sql.DB) *MysqlUserRepository {
	return &MysqlUserRepository{Conn}
}

func (m *MysqlUserRepository) GetUser(username string) (*User, error) {

	log.Println("Using connection: ", psqlInfo)
	db, err := sql.Open("postgres", psqlInfo)
	checkError(err)

	var user User

	row := db.QueryRow(
		"SELECT * FROM users WHERE Username=$1",
		username,
	)
	switch err := row.Scan(&user.Username, &user.Password, &user.Phone_numer, &user.Fhir_server_address, &user.Patient_id); err {
	case sql.ErrNoRows:
		fmt.Println("No rows were returned!")
		return nil, err
	case nil:
		fmt.Println(user)
		return &user, nil
	default:
		log.Println(err)
		return nil, err
	}

}

func checkError(err error) {
	fmt.Println("Checking error")
	if err != nil {
		fmt.Println("GOt error ", err)
		panic(err)
	}
}
