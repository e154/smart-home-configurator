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
	"fmt"
	"github.com/e154/smart-home-dashboard/common"
	"github.com/e154/smart-home-dashboard/system/graceful_service"
	"github.com/e154/smart-home-dashboard/system/logging"
	"github.com/e154/smart-home-dashboard/system/server"
	"github.com/e154/smart-home-dashboard/version"
	"os"
)

var (
	log = common.MustGetLogger("main")
)

func main() {

	args := os.Args[1:]
	for _, arg := range args {
		switch arg {
		case "-v", "--version":
			fmt.Printf(version.ShortVersionBanner, version.GetHumanVersion())
			return
		default:
			fmt.Printf(version.VerboseVersionBanner, "v2", os.Args[0])
			return
		}
	}

	start()
}

func start() {

	fmt.Printf(version.ShortVersionBanner, "")

	container := BuildContainer()
	container.Invoke(func(
		logger *logging.Logging,
		graceful *graceful_service.GracefulService,
		server *server.Server) {

		server.Start()
		graceful.Wait()
	})
}
