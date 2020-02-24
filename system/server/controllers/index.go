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

package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/sessions"
	"fmt"
	"encoding/json"
	m "github.com/e154/smart-home-configurator/models"
	"errors"
)

type ControllerIndex struct {
	*ControllerCommon
}

func NewControllerIndex(common *ControllerCommon) *ControllerIndex {
	return &ControllerIndex{ControllerCommon: common}
}

func (i ControllerIndex) Index(c *gin.Context) {

	session := sessions.Default(c)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		c.Redirect(302, "/signin")
		return
	}

	i.showPage(c)

	return
}

func (i ControllerIndex) Signin(ctx *gin.Context) {

	session := sessions.Default(ctx)

	if i.IsAjax(ctx) {
		username, password, ok := ctx.Request.BasicAuth()
		if !ok {
			ctx.AbortWithError(401, errors.New(""))
			return
		}

		uri := fmt.Sprintf("%s://%s:%d/api/v1/signin", i.cfg.ApiScheme, i.cfg.ApiAddr, i.cfg.ApiPort)
		r, body, errs := i.getAgent().
			Post(uri).
			SetBasicAuth(username, password).
			End()
		if len(errs) != 0 {
			ctx.AbortWithError(500, errs[0])
			return
		}

		if r.StatusCode != 200 {
			ctx.AbortWithError(r.StatusCode, errors.New(""))
			return
		}

		current := struct {
			Token string `json:"access_token"`
			User  m.User `json:"current_user"`
		}{}

		if err := json.Unmarshal([]byte(body), &current); err != nil {
			ctx.AbortWithError(500, err)
			return
		}

		session.Set("userinfo", current.User)
		session.Set("access_token", current.Token)
		session.Save()

		ctx.JSON(200, gin.H{
			"access_token": current.Token,
		})
		return
	}

	userinfo := session.Get("userinfo")
	if userinfo != nil {
		ctx.Redirect(302, "/")
		return
	}

	i.showPage(ctx)

	return
}

func (i ControllerIndex) Signout(c *gin.Context) {

	session := sessions.Default(c)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		c.Redirect(302, "/signin")
	}

	session.Delete("userinfo")
	session.Delete("access_token")
	session.Save()

	c.Redirect(302, "/signin")

	return
}

func (i ControllerIndex) Recovery(c *gin.Context) {
	c.JSON(200, struct {
	}{})
	return
}

func (i ControllerIndex) Reset(c *gin.Context) {
	c.JSON(200, struct {
	}{})
	return
}
