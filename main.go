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

package main

import (
	"os"
	"fmt"
	"github.com/op/go-logging"
	"github.com/sirupsen/logrus"
	"github.com/e154/smart-home-configurator/system/graceful_service"
	l "github.com/e154/smart-home-configurator/system/logging"
	"github.com/e154/smart-home-configurator/system/server"
)

var (
	log = logging.MustGetLogger("main")
)

func main() {

	args := os.Args[1:]
	for _, arg := range args {
		switch arg {
		case "-v", "--version":
			fmt.Printf(shortVersionBanner, GetHumanVersion())
			return
		default:
			fmt.Printf(verboseVersionBanner, "v2", os.Args[0])
			return
		}
	}

	start()
}

func start() {

	fmt.Printf(shortVersionBanner, "")

	container := BuildContainer()
	container.Invoke(func(
		graceful *graceful_service.GracefulService,
		lx *logrus.Logger,
		server *server.Server) {
		l.Initialize(lx)
		server.Start()
		graceful.Wait()
	})
}
