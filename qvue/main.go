package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	_ "github.com/lib/pq"

	auth0 "github.com/auth0-community/go-auth0"
	"github.com/gorilla/mux"
	jose "gopkg.in/square/go-jose.v2"
	jwt "gopkg.in/square/go-jose.v2/jwt"
)

const jwksURI = "https://chronolog.eu.auth0.com/.well-known/jwks.json"
const auth0ApiIssuer = "https://chronolog.eu.auth0.com/"

var auth0ApiAudience = []string{"https://chronolog.eu.auth0.com/api/v2/"}

// Fact DTO
type Fact struct {
	ID    int    `json:"id"`
	Title string `json:"title"`
}

// Response to frontend
type Response struct {
	Message string `json:"message"`
	Facts   []Fact `json:"facts"`
}

func fatalOnErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func getFacts() []Fact {
	db, err := sql.Open("postgres",
		"postgres://developer:dev@localhost:5432/chrono_dev_db?sslmode=disable")
	fatalOnErr(err)

	rows, err := db.Query("SELECT * FROM facts")

	fatalOnErr(err)
	defer rows.Close()

	var facts []Fact

	for rows.Next() {
		var factID int
		var factTypeID int
		var description string

		err = rows.Scan(&description, &factTypeID, &factID)
		facts = append(facts, Fact{ID: factID, Title: description})
	}

	err = rows.Err()
	fatalOnErr(err)

	return facts
}

func main() {
	r := mux.NewRouter()

	// This route is always accessible
	r.Handle("/api/public", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "OPTIONS" {
			w.Header().Set("Access-Control-Allow-Methods", "OPTIONS, GET, PUT, DELETE")
			w.Header().Set("Access-Control-Allow-Origin", "*") // todo replace star to url
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
			w.WriteHeader(http.StatusOK)
		} else {

			response := Response{
				Message: "Public  call: No access",
			}

			// TODO: copypaste headers init
			w.Header().Set("Content-Type", "application/json")
			w.Header().Set("Access-Control-Allow-Origin", "*") // TODO: replace star to url
			w.WriteHeader(http.StatusOK)
			json.NewEncoder(w).Encode(response)
			fmt.Println("Call public")
		}
	}))

	// This route is only accessible if the user has a valid access_token with the read:messages scope
	// We are wrapping the checkJwt middleware around the handler function which will check for a
	// valid token and scope.
	r.Handle("/api/private", checkJwt(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		response := Response{
			Message: "From public",
			Facts:   getFacts(),
		}

		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Access-Control-Allow-Origin", "*") // todo replace star to url
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(response)
	})))

	fmt.Println("Start listening on http://lvh.me:3001")
	http.ListenAndServe(":3001", r)
}

func checkJwt(h http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "OPTIONS" {
			w.Header().Set("Access-Control-Allow-Methods", "OPTIONS, GET, PUT, DELETE")
			w.Header().Set("Access-Control-Allow-Origin", "*") // todo replace star to url
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
			w.WriteHeader(http.StatusOK)
		} else {
			client := auth0.NewJWKClient(auth0.JWKClientOptions{URI: jwksURI})
			audience := auth0ApiAudience

			configuration := auth0.NewConfiguration(client, audience, auth0ApiIssuer, jose.RS256)
			validator := auth0.NewValidator(configuration)
			token, err := validator.ValidateRequest(r)

			if err != nil {
				fmt.Println("Token is not valid or missing token: ", err.Error())
				response := Response{
					Message: "Missing or invalid token.",
				}

				w.Header().Set("Content-Type", "text/html; charset=utf-8")
				w.Header().Set("Access-Control-Allow-Origin", "*")
				w.WriteHeader(http.StatusUnauthorized)
				json.NewEncoder(w).Encode(response)

			} else {
				// Ensure the token has the correct scope
				result := checkScope(r, validator, token)
				if result == true {
					h.ServeHTTP(w, r)
					// If the token is valid and we have the right scope, we'll pass through the middleware
				} else {
					response := Response{
						Message: "You do not have the read:messages scope.",
					}
					w.Header().Set("Content-Type", "text/html; charset=utf-8")
					w.Header().Set("Access-Control-Allow-Origin", "*")
					w.WriteHeader(http.StatusUnauthorized)
					json.NewEncoder(w).Encode(response)
				}
			}
		}
	})
}

func checkScope(r *http.Request, validator *auth0.JWTValidator, token *jwt.JSONWebToken) bool {
	return true
	// claims := map[string]interface{}{}
	// err := validator.Claims(r, token, &claims)
	//
	// if err != nil {
	// 	fmt.Println(err)
	// 	return false
	// }
	//
	// if strings.Contains(claims["scope"].(string), "read:rules") {
	// 	return true
	// } else {
	// 	return false
	// }
}
