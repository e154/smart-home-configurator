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
	"context"
	"fmt"
	"github.com/e154/smart-home-configurator/common"
	"github.com/e154/smart-home-configurator/system/config"
	"github.com/e154/smart-home-configurator/system/graceful_service"
	"github.com/e154/smart-home-configurator/system/server/controllers"
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

var (
	log = common.MustGetLogger("server")
)

type Server struct {
	Config      *ServerConfig
	Controllers *controllers.Controllers
	engine      *gin.Engine
	server      *http.Server
	logger      *ServerLogger
}

func (s *Server) Start() {

	s.server = &http.Server{
		Addr:    fmt.Sprintf("%s:%d", s.Config.Host, s.Config.Port),
		Handler: s.engine,
	}

	go func() {
		// service connections
		if err := s.server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("listen: %s\n", err)
		}
	}()

	log.Infof("Serving server at http://[::]:%d", s.Config.Port)
}

func (s *Server) Shutdown() {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()
	if err := s.server.Shutdown(ctx); err != nil {
		log.Error(err.Error())
	}
	log.Info("Server exiting")
}

func NewServer(cfg *ServerConfig,
	ctrls *controllers.Controllers,
	graceful *graceful_service.GracefulService) (newServer *Server) {

	logger := NewLogger()

	gin.DisableConsoleColor()
	gin.DefaultWriter = logger
	gin.DefaultErrorWriter = logger
	if cfg.RunMode == config.ReleaseMode {
		gin.SetMode(gin.ReleaseMode)
	} else {
		gin.SetMode(gin.DebugMode)
	}

	engine := gin.New()
	engine.Use(gin.Recovery())

	newServer = &Server{
		Config:      cfg,
		Controllers: ctrls,
		engine:      engine,
		logger:      logger,
	}

	graceful.Subscribe(newServer)

	newServer.setControllers()

	return
}
