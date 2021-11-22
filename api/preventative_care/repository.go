package preventative_care

import (
	"database/sql"
	"fmt"
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

type Repository interface {
	GetPreventativeCareItems(req RecommendedPreventativeCareItemRequest) ([]RecommendedPreventativeCareItem, error)
}

type mysqlRepository struct {
	Conn *sql.DB
}

func NewRepository() Repository {
	return &mysqlRepository{}
}

func (r *mysqlRepository) GetPreventativeCareItems(req RecommendedPreventativeCareItemRequest) ([]RecommendedPreventativeCareItem, error) {

	db, err := sql.Open("postgres", psqlInfo)
	checkError(err)

	var query = "SELECT *" +
		"FROM recommended_preventative_services " +
		"WHERE (gender = 'all' or gender = $1) " +
		"AND (age_range_max > $2) " +
		"AND age_range_min < $2 "

	log.Println("Calling query for recommendendations ")
	rows, err := db.Query(query, req.Gender, req.Age)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var items []RecommendedPreventativeCareItem

	for rows.Next() {
		var item RecommendedPreventativeCareItem
		var potentiallyNull sql.NullInt32
		if err := rows.Scan(&item.Id, &item.SearchTerm, &item.Title, &item.Description,
			&item.Gender, &item.AgeRangeMin, &item.AgeRangeMax, &item.SmokingHistory,
			&item.Recurring, &potentiallyNull); err != nil {
			log.Println("Issue querying database got error: ", err)
			return items, err
		}
		item.AnnualInterval = 0
		if potentiallyNull.Valid {
			item.AnnualInterval = int(potentiallyNull.Int32)
		}

		items = append(items, item)

		if err = rows.Err(); err != nil {
			log.Println("Issue querying database got error: ", err)
			return items, err
		}
	}

	log.Printf("Found %s rows\n", len(items))

	return items, nil

}
func checkError(err error) {
	fmt.Println("Checking error")
	if err != nil {
		fmt.Println("GOt error ", err)
	}
}
