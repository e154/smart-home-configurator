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
	m "github.com/e154/smart-home-dashboard/models"
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/memstore"
	"github.com/gin-gonic/gin"
	"strings"
)

func (s *Server) setControllers() {

	r := s.engine
	store := memstore.NewStore([]byte(s.Config.MemStorySecret))
	r.Use(sessions.Sessions(s.Config.SessionStory, store))

	basePath := r.Group("/")
	basePath.Any("/*any", s.customRouter)
}

func (s *Server) customRouter(ctx *gin.Context) {

	r := strings.ToLower(ctx.Request.RequestURI)
	method := ctx.Request.Method
	log.Infof("[%s] %s", (method + "    ")[:4], r)

	session := sessions.Default(ctx)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		switch {
		case strings.Contains(r, "/login") && method == "POST":
			s.Controllers.Public.Login(ctx)
		default:
			s.Controllers.Public.Index(ctx)
		}

		return
	}

	user := userinfo.(*m.User)

	switch {
	case r == "/logout":
		s.Controllers.Private.Logout(ctx, user)
	default:
		s.Controllers.Private.Index(ctx, user)
	}
}
