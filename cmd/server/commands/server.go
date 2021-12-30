// This file is part of the Smart Home
// Program complex distribution https://github.com/e154/smart-home
// Copyright (C) 2016-2021, Filippov Alex
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

package commands

import (
	"fmt"
	v1 "github.com/e154/smart-home-configurator/api/v1"

	. "github.com/e154/smart-home-configurator/cmd/server/container"
	. "github.com/e154/smart-home-configurator/common"
	"github.com/e154/smart-home-configurator/system/logging"
	"github.com/e154/smart-home-configurator/version"
	"github.com/spf13/cobra"
	"go.uber.org/fx"
)

var (
	// Server ...
	Server = &cobra.Command{
		Use:   "server",
		Short: fmt.Sprintf(version.ShortVersionBanner, ""),
		Run: func(cmd *cobra.Command, args []string) {

			fmt.Printf(version.ShortVersionBanner, "")

			app := BuildContainer(fx.Invoke(func(
				logger *logging.Logging,
				server *v1.Server,
			) {
				server.Start()
			}))

			Start(app)

			Work()

			Stop(app)
		},
	}
)

func init() {
	Server.AddCommand(versionCmd)
}
