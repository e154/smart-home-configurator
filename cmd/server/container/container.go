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

package container

import (
	v1 "github.com/e154/smart-home-configurator/api/v1"
	"github.com/e154/smart-home-configurator/api/v1/controllers"
	"github.com/e154/smart-home-configurator/models"
	"github.com/e154/smart-home-configurator/system/client"
	"github.com/e154/smart-home-configurator/system/config"
	"github.com/e154/smart-home-configurator/system/logging"
	"go.uber.org/fx"
)

// BuildContainer ...
func BuildContainer(opt fx.Option) (app *fx.App) {

	app = fx.New(
		fx.Provide(
			func() (*models.AppConfig, error) {
				return config.ReadConfig("conf", "config.json", "")
			},
			logging.NewLogger,
			NewApiConfig,
			controllers.NewControllers,
			client.NewClient,
			v1.NewServer,
		),
		fx.Logger(NewPrinter()),
		opt,
	)

	return
}
