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

package controllers

import (
	m "github.com/e154/smart-home-configurator/models"
	"github.com/e154/smart-home-configurator/system/client"
)

// Controllers ...
type Controllers struct {
	*ControllerIndex
	*ControllerWs
}

// NewControllers ...
func NewControllers(client *client.Client,
	config *m.AppConfig) *Controllers {
	common := NewControllerCommon(client, config)
	return &Controllers{
		ControllerIndex: NewIndexController(common),
		ControllerWs:    NewWsController(common),
	}
}
