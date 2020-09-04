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
	"crypto/tls"
	"errors"
	"fmt"
	m "github.com/e154/smart-home-dashboard/models"
	"github.com/e154/smart-home-dashboard/system/config"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/parnurzeal/gorequest"
	"html/template"
	"net/http"
	"reflect"
)

type ControllerCommon struct {
	cfg *config.AppConfig
}

func NewControllerCommon(cfg *config.AppConfig) *ControllerCommon {
	return &ControllerCommon{
		cfg: cfg,
	}
}

func (c *ControllerCommon) getUser(ctx *gin.Context) (user *m.User, err error) {
	session := sessions.Default(ctx)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		err = errors.New("userinfo is nil")
		return
	}
	user = userinfo.(*m.User)
	return
}

func (c ControllerCommon) getAgent() *gorequest.SuperAgent {

	req := gorequest.New()
	req.Transport = &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	return req
}

func (c ControllerCommon) getApiEndpoint(path string) string {
	return fmt.Sprintf("%s://%s:%d%s", c.cfg.ApiScheme, c.cfg.ApiAddr, c.cfg.ApiPort, path)
}


func (c ControllerCommon) funcMap() map[string]interface{} {
	return map[string]interface{}{
		"safeHtml": func(s string) template.HTML { return template.HTML(s) },
		"safeCss":  func(s string) template.CSS { return template.CSS(s) },
		"safeUrl":  func(s string) template.URL { return template.URL(s) },
		"safeJs":   func(s string) template.JS { return template.JS(s) },
		"attr":     func(s string) template.HTMLAttr { return template.HTMLAttr(s) },
		"last":     func(i int, s interface{}) bool { return i == reflect.ValueOf(s).Len()-1 },
		"len":      func(s interface{}) int { return reflect.ValueOf(s).Len() },
	}
}
