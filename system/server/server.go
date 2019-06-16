package server

import (
	"fmt"
	"net/http"
	"time"
	"context"
	"github.com/op/go-logging"
	"github.com/gin-gonic/gin"
	"github.com/e154/smart-home-configurator/system/graceful_service"
	"github.com/e154/smart-home-configurator/system/server/controllers"
	"github.com/e154/smart-home-configurator/system/config"
)

var (
	log = logging.MustGetLogger("server")
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

	logger := &ServerLogger{log}

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
