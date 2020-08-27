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

package models

import (
	"encoding/gob"
	"time"
)

type User struct {
	Id              int64          `json:"id"`
	Nickname        string         `json:"nickname"`
	FirstName       string         `json:"first_name"`
	LastName        string         `json:"last_name"`
	Email           string         `json:"email"`
	History         []*UserHistory `json:"history"`
	Status          string         `json:"status"`
	Image           *Image         `json:"image"`
	SignInCount     int64          `json:"sign_in_count"`
	CurrentSignInIp string         `json:"current_sign_in_ip"`
	LastSignInIp    string         `json:"last_sign_in_ip"`
	CreatedBy       *User          `json:"created_by"`
	Role            *Role          `json:"role"`
	Meta            []*UserMeta    `json:"meta"`
	Lang            string         `json:"lang"`
	CurrentSignInAt *time.Time     `json:"current_sign_in_at"`
	LastSignInAt    *time.Time     `json:"last_sign_in_at"`
	CreatedAt       time.Time      `json:"created_at"`
	UpdatedAt       time.Time      `json:"updated_at"`
}

func init() {
	gob.Register(new(User))
}
