package config

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

const path = "conf/config.json"

func ReadConfig() (conf *AppConfig, err error) {
	var file []byte
	file, err = ioutil.ReadFile(path)
	if err != nil {
		log.Fatal("Error reading config file")
		return
	}
	conf = &AppConfig{}
	err = json.Unmarshal(file, &conf)
	if err != nil {
		log.Fatal("Error: wrong format of config file")
		return
	}

	checkEnv(conf)

	return
}

func checkEnv(conf *AppConfig) {

	if httpaddr := os.Getenv("HTTP_ADDR"); httpaddr != "" {
		conf.Httpaddr = httpaddr
	}

	if httpport := os.Getenv("HTTP_PORT"); httpport != "" {
		v, _ := strconv.ParseInt(httpport, 10, 32)
		conf.Httpport = int(v)
	}

	if runmode := os.Getenv("RUNMODE"); runmode != "" {
		conf.Runmode = RunMode(runmode)
	}

	if apiAddr := os.Getenv("API_ADDR"); apiAddr != "" {
		conf.ApiAddr = apiAddr
	}

	if apiPort := os.Getenv("API_PORT"); apiPort != "" {
		v, _ := strconv.ParseInt(apiPort, 10, 32)
		conf.ApiPort = int(v)
	}

	if apiScheme := os.Getenv("API_SCHEME"); apiScheme != "" {
		conf.ApiScheme = apiScheme
	}

	if memStorySecret := os.Getenv("MEM_STORY_SECRET"); memStorySecret != "" {
		conf.MemStorySecret = memStorySecret
	}

	if sessionStory := os.Getenv("SESSION_STORY"); sessionStory != "" {
		conf.SessionStory = sessionStory
	}
}
