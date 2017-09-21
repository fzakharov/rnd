package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

func fatalOnErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func viewHandler(w http.ResponseWriter, r *http.Request) {
	db, err := sql.Open("postgres", "postgres://developer:dev@localhost:5432/chrono_dev_db?sslmode=disable")
	fatalOnErr(err)

	rows, err := db.Query("SELECT * FROM facts WHERE fact_id = $1", r.URL.Path[len("/api/v1/facts/"):])
	fatalOnErr(err)
	defer rows.Close()

	for rows.Next() {
		var factID int
		var factTypeID int
		var description string
		err = rows.Scan(&description, &factTypeID, &factID)
		fatalOnErr(err)
		fmt.Fprintf(w, "{fact_id:%b, fact_type_id:%b, description:%s}", factID, factTypeID, description)
	}

	err = rows.Err()
	fatalOnErr(err)
}

func aamain() {
	http.HandleFunc("/api/v1/facts/", viewHandler)
	http.ListenAndServe(":8080", nil)
}
