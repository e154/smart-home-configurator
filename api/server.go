package api

import (
	"context"
	"github.com/e154/smart-home-configurator/api/controllers"
	"github.com/e154/smart-home-configurator/common/logger"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"go.uber.org/fx"
	"html/template"
	"net/http"
	"net/url"
	"strings"
)

var (
	log = logger.MustGetLogger("api")
)

// Server ...
type Server struct {
	echo        *echo.Echo
	cfg         Config
	controllers *controllers.Controllers
}

// NewServer ...
func NewServer(lc fx.Lifecycle,
	cfg Config,
	controllers *controllers.Controllers) (srv *Server) {

	srv = &Server{
		controllers: controllers,
		cfg:         cfg,
	}

	lc.Append(fx.Hook{
		OnStop: func(ctx context.Context) error {
			return srv.Shutdown(ctx)
		},
	})

	return
}

// Start ...
func (s *Server) Start() {

	s.echo = echo.New()
	s.echo.HideBanner = true
	s.echo.HidePort = true

	if s.cfg.Debug {
		var format = `INFO	api	[${method}] ${uri} ${status} ${latency_human} ${error}` + "\n"
		log.Info("debug enabled")
		DefaultLoggerConfig := middleware.LoggerConfig{
			Skipper:          middleware.DefaultSkipper,
			Format:           format,
			CustomTimeFormat: "2006-01-02 15:04:05.00000",
		}
		s.echo.Use(middleware.LoggerWithConfig(DefaultLoggerConfig))
		s.echo.Debug = true
	} else {
		log.Info("debug disabled")
	}

	// cors
	s.echo.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodHead, http.MethodPut, http.MethodPatch, http.MethodPost, http.MethodDelete},
	}))

	// render
	renderer := &TemplateRenderer{
		templates: template.Must(template.ParseGlob("build/*/**.html")),
	}
	s.echo.Renderer = renderer

	// index
	s.echo.GET("/", s.controllers.Index)

	// ws
	s.echo.GET("/ws", s.controllers.Ws)

	if err := s.setUpProxy(); err != nil {
		log.Error(err.Error())
	}

	// static
	s.echo.Static("/public", "build/public")

	go func() {
		_ = s.echo.Start(s.cfg.String())
	}()
	log.Infof("server started at %s", s.cfg.String())
}

// Shutdown ...
func (s *Server) Shutdown(ctx context.Context) error {
	defer func() {
		log.Info("server shutdown")
	}()
	return s.echo.Shutdown(ctx)
}

func (s *Server) setUpProxy() (err error) {

	log.Infof("set proxy http requests to %s", s.cfg.ApiHostPort)

	var url1 *url.URL
	url1, err = url.Parse(s.cfg.ApiHostPort)
	if err != nil {
		return
	}

	targets := []*middleware.ProxyTarget{{URL: url1}}
	rrb := middleware.NewRoundRobinBalancer(targets)
	s.echo.Use(middleware.ProxyWithConfig(middleware.ProxyConfig{
		Skipper: func(e echo.Context) bool {
			r := e.Request()
			//fmt.Println("url:", r.URL.String())
			if strings.Contains(r.URL.String(), "/v1/") {
				return false
			}
			if strings.Contains(r.URL.String(), "swagger") {
				return false
			}
			if strings.Contains(r.URL.String(), "upload") && r.Method == "GET" {
				return false
			}
			return true
		},
		Balancer: rrb,
	}))

	return
}
