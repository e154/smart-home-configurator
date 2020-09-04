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

type AppConfig struct {
	Httpaddr       string  `json:"httpaddr"`
	Httpport       int     `json:"httpport"`
	Runmode        RunMode `json:"runmode"`
	ApiAddr        string  `json:"api_addr"`
	ApiPort        int     `json:"api_port"`
	ApiScheme      string  `json:"api_scheme"`
	MemStorySecret string  `json:"mem_story_secret"`
	SessionStory   string  `json:"session_story"`
	BasePath       string  `json:"base_path"`
}

type RunMode string

const (
	DebugMode   = RunMode("debug")
	ReleaseMode = RunMode("release")
)
