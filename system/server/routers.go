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

package server

import (
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/memstore"
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
	"html/template"
	"reflect"
	"strings"
)

func (s *Server) setControllers() {

	r := s.engine
	store := memstore.NewStore([]byte(s.Config.MemStorySecret))
	r.Use(sessions.Sessions(s.Config.SessionStory, store))

	r.Use(static.Serve("/static", static.LocalFile("./build/private", true)))
	r.Use(static.Serve("/_static", static.LocalFile("./build/public", true)))
	r.Use(static.Serve("/favicon.ico", static.LocalFile("./build/favicon.ico", false)))

	basePath := r.Group("/")
	basePath.Any("/*any", s.customRouter)

	funcMap := map[string]interface{}{
		"safeHtml": func(s string) template.HTML { return template.HTML(s) },
		"safeCss":  func(s string) template.CSS { return template.CSS(s) },
		"safeUrl":  func(s string) template.URL { return template.URL(s) },
		"safeJs":   func(s string) template.JS { return template.JS(s) },
		"attr":     func(s string) template.HTMLAttr { return template.HTMLAttr(s) },
		"last":     func(i int, s interface{}) bool { return i == reflect.ValueOf(s).Len()-1 },
		"len":      func(s interface{}) int { return reflect.ValueOf(s).Len() },
	}
	r.SetFuncMap(funcMap)
	r.LoadHTMLGlob("views/*")
}

func (s *Server) customRouter(ctx *gin.Context) {

	r := strings.ToLower(ctx.Request.RequestURI)
	method := ctx.Request.Method + "    "
	log.Infof("[%s] %s", method[:4], r)

	if strings.Contains(r, "/static") || strings.Contains(r, "/_static") {
		return
	}

	switch {
	case r == "/signin":
		s.Controllers.Index.Signin(ctx)
	case r == "/signout":
		s.Controllers.Index.Signout(ctx)
	case r == "/recovery":
		s.Controllers.Index.Recovery(ctx)
	case r == "/reset":
		s.Controllers.Index.Reset(ctx)
	case strings.Contains(r, "/api/v1/image/upload"):
		s.Controllers.Proxy.Upload(ctx)
	case strings.Contains(r, "/upload"), strings.Contains(r, "/api_static"):
		s.Controllers.Proxy.Simple(ctx)
	case strings.Contains(r, "/api/v1/ws"):
		s.Controllers.Proxy.Ws(ctx)
	case strings.Contains(r, "/api/v1"):
		s.Controllers.Proxy.Simple(ctx)
	default:
		s.Controllers.Index.Index(ctx)
	}
}
