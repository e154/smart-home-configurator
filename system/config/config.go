// This file is part of the Smart Home
// Program complex distribution https://github.com/e154/smart-home
// Copyright (C) 2016-2020, Filippov Alex
//
// This library is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Library General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library.  If not, see
// <https://www.gnu.org/licenses/>.

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
