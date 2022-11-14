package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"strconv"
	"time"
)

type User struct {
	Userid     string     `json:"userid"`
	Secretcode string     `json:"secretcode"`
	Name       string     `json:"name"`
	Email      string     `json:"email"`
	Plist      []Playlist `json:"plist"`
}

type Playlist struct {
	Sc    string `json:"sc"`
	Pid   string `json:"pid"`
	Pname string `json:"pname"`
	Slist []Song `json:"slist"`
}

type Song struct {
	Sc       string `json:"sc"`
	Sid      string `json:"sid"`
	Sname    string `json:"sname"`
	Musicurl string `json:"musicurl"`
}
type Data struct {
	Sec  string `json:"sec"`
	Play string `json:"play"`
	Son  string `json:"son"`
}

// fake DB
var userrecord []User
var playlist []Playlist
var songs []Song

func Register(w http.ResponseWriter, r *http.Request) {
	//get value from user (through URl body)
	w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
	log.Println(r.Header.Get("Origin"))
	w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	if r.Method == "POST" {
		var newUser User
		//receiving request then decoding in newuser
		err := json.NewDecoder(r.Body).Decode(&newUser)
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
		//generating UserId and Secretcode
		newUser.Secretcode = random()
		newUser.Userid = random()
		//now sending back newUser
		newUser.Plist = []Playlist{}
		userrecord = append(userrecord, newUser)

		err2 := json.NewEncoder(w).Encode(newUser)
		if err2 != nil {
			http.Error(w, err.Error(), 500)
			return
		}
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
	}
}
func Login(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
	log.Println(r.Header.Get("Origin"))
	w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "*")

	var newUser User
	if r.Method == "POST" {

		err := json.NewDecoder(r.Body).Decode(&newUser)
		if err != nil {
			http.Error(w, err.Error(), 500)

			return
		}


		for _, t := range userrecord {
			if t.Secretcode == newUser.Secretcode {
				err := json.NewEncoder(w).Encode(t)
				if err != nil {
					http.Error(w, err.Error(), 500)

					return
				}

			}
		}
	}
}

func ViewProfile(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
	log.Println(r.Header.Get("Origin"))
	w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "*")

	var newUser User
	if r.Method == "POST" {
		err := json.NewDecoder(r.Body).Decode(&newUser)
		if err != nil {
			http.Error(w, err.Error(), 500)

			return
		}
		
		newUser.Plist = []Playlist{}

		for _, t := range userrecord {
			if t.Secretcode == newUser.Secretcode {
				err := json.NewEncoder(w).Encode(t)
				if err != nil {
					http.Error(w, err.Error(), 500)
					return
				}

			}
		}

	}
}

func createplaylist(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
	log.Println(r.Header.Get("Origin"))
	w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "*")

	var playlist Playlist

	err := json.NewDecoder(r.Body).Decode(&playlist)

	log.Println(playlist)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	for index, item := range userrecord {
		if playlist.Sc == item.Secretcode {
			playlist.Pid = random()
			log.Println("A")
			log.Println(playlist)
			log.Println("v")
			userrecord[index].Plist = append(userrecord[index].Plist, playlist)
			er := json.NewEncoder(w).Encode(userrecord[index].Plist)
			if er != nil {
				log.Printf("3: %v", err.Error())
				http.Error(w, err.Error(), http.StatusBadRequest)
			}
			return
		}
	}
	err = json.NewEncoder(w).Encode(userrecord)
}

func AddIn(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", r.Header.Get("Origin"))
	log.Println(r.Header.Get("Origin"))
	w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	var us Playlist

	_ = json.NewDecoder(r.Body).Decode(&us)

	for index, item := range userrecord {
		if us.Sc == item.Secretcode {
			for index2, item2 := range userrecord[index].Plist {
				if us.Pid == item2.Pid {
					for index3 := range userrecord[index].Plist[index2].Slist {
						us.Slist[index3].Sid = strconv.Itoa(rand.Intn(1000000))
						userrecord[index].Plist[index2].Slist = append(userrecord[index].Plist[index2].Slist, us.Slist[index3])
						_ = json.NewEncoder(w).Encode(us.Slist[index3])

					}
				}
			}
		}
	}
}

func deleteSongFromP(w http.ResponseWriter, r *http.Request) {

	var user Data
	_ = json.NewDecoder(r.Body).Decode(&user)

	for index, item := range userrecord {
		if user.Sec == item.Secretcode {
			for index2, item2 := range userrecord[index].Plist {
				if user.Play == item2.Pid {
					for index3, item3 := range userrecord[index].Plist[index2].Slist {
						if user.Son == item3.Sid {
							userrecord[index].Plist[index2].Slist = append(userrecord[index].Plist[index2].Slist[:index3], userrecord[index].Plist[index2].Slist[index3+1:]...)
							err := json.NewEncoder(w).Encode(item2)
							if err != nil {
								http.Error(w, err.Error(), http.StatusBadRequest)
								return
							}

							return
						}
					}
				}
			}
		}
	}
}

func getAllSong(w http.ResponseWriter, r *http.Request) {
	var newUser User
	if r.Method == "POST" {
		for _, t := range userrecord {
			if t.Secretcode == newUser.Secretcode {
				for _, t := range t.Plist {
					fmt.Println(t.Slist)
					err := json.NewEncoder(w).Encode(t.Slist)
					if err != nil {
						http.Error(w, err.Error(), 500)

						return
					}
				}
			}

		}
	}
}
func random() string {
	rand.Seed(time.Now().UnixNano())
	return strconv.Itoa(rand.Intn(100))

}
func main() {
	http.HandleFunc("/", Register)
	http.HandleFunc("/login", Login)
	http.HandleFunc("/viewprofile", ViewProfile)
	http.HandleFunc("/createplaylist", createplaylist)
	http.HandleFunc("/addsong", AddIn)
	http.HandleFunc("/delete", deleteSongFromP)
	http.HandleFunc("/getallsong", getAllSong)

	err := http.ListenAndServe("localhost:8080", nil)
	if err != nil {

		return
	}
}
