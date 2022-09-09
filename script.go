package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"
)

func request(url string) {
	resp, err := http.Get(url)
	if err != nil {
		log.Fatalln(err)
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
	}

	log.Println(body)
}

func input(text string) string {
	fmt.Print(text)

	// var then variable name then variable type
	var first string

	// Taking input from user
	fmt.Scanln(&first)

	return first
}

func parseResponse(text string) {
	trophy := strings.Split(text, `"SkillRating":`)[1]
	trophy = strings.Split(trophy, ",")[0]
	crown := strings.Split(text, `"Crowns":`)[1]
	crown = strings.Split(crown, ",")[0]
	username := strings.Split(text, `"Username":`)[1]
	username = strings.Split(username, ",")[0]

	fmt.Printf("\r[ OK ] [Usuario : %s | Trofeus : %s | Coroas : %s ]", username, trophy, crown)
}

func requestWithHeader(url string, token string) {
	client := &http.Client{}
	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Set("Host", "stumblepremiumlive.kitkagames.com")
	req.Header.Set("use_response_compression", "true")
	req.Header.Set("authorization", token)

	res, _ := client.Do(req)
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
	}

	if res.StatusCode == 200 {
		parseResponse(string(body))
	}
	if res.StatusCode == 401 {
		fmt.Printf("\n[ ! ] Sua auth expirou > [ Status code = 401 ]")
	}
	if res.StatusCode == 403 {
		fmt.Printf("\n[ ! ] Sua conta foi banida > [ Status code = 403 ]")
	}
	if res.StatusCode == 501 {
		fmt.Printf("\n[ ! ] Falhou > [ Status code = 501 ]")
	}

}

func main() {

	fmt.Printf("\n -------------------------------------------------------")
	fmt.Printf("\n |           > Simples duplicador em Golang <          |")
	fmt.Printf("\n |=====================================================|")
	fmt.Printf("\n |         Estas ferramentas feitas por Ryns           |")
	fmt.Printf("\n |            recodificadas por iSholved!              |")
	fmt.Printf("\n |-----------------------------------------------------|")
	fmt.Printf("\n |         ferramenta atualizada por gucciMp4          |")
	fmt.Printf("\n |               Tiktok: @gucci..mp4                   |")
	fmt.Printf("\n |               Discord: Gucci#2661                   |")
	fmt.Printf("\n -------------------------------------------------------")

	fmt.Printf("\n\n\n[ 1 ] Rodada 1.\n[ 2 ] Rodada 2.\n[ 3 ] Rodada 3.")

	round := input("\n\n[ > ] Coloque seu round: ")
	token := input("\n[ > ] Sua auth: ")
	thread := input("\n[ ! ] (Recomendado 1) [0 threads = 1]\n[ > ] Threads: ")
	fmt.Printf("\n[ ! ] Aviso o tempo é de 2 a 10 segs para cada Thread\n")
	fmt.Printf("\n=-------------------->[Fazendo requisições]<--------------------=")
	fmt.Printf("\n")
	thrd, _ := strconv.Atoi(thread)
	url := "https://stumblepremiumlive.kitkagames.com/round/finishv2/" + round

	for i := 0; i < thrd; i++ {
		go func() {
			for {
				requestWithHeader(url, token)
			}
		}()
	}
	for {
		time.Sleep(978 * time.Millisecond)
		requestWithHeader(url, token)
	}

}
