package v1

import (
	"context"
	"github.com/e154/smart-home-configurator/api/v1/controllers"
	"github.com/e154/smart-home-configurator/common"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"go.uber.org/fx"
	"html/template"
	"net/http"
	"net/url"
	"strings"
)

var (
	log = common.MustGetLogger("api/v1")
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

	// cors
	s.echo.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodHead, http.MethodPut, http.MethodPatch, http.MethodPost, http.MethodDelete},
	}))

	// render
	renderer := &TemplateRenderer{
		templates: template.Must(template.ParseGlob("build/public/*.html")),
	}
	s.echo.Renderer = renderer

	// index
	s.echo.GET("/", s.controllers.Index)

	if err := s.setUpProxy(); err != nil {
		log.Error(err.Error())
	}

	// static
	s.echo.Static("static", "build/public/static")
	s.echo.Static("favicon.ico", "build/public/favicon.ico")

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
			if strings.Contains(r.URL.String(), "/v1/") || strings.Contains(r.URL.String(), "swagger") {
				return false
			}
			return true
		},
		Balancer: rrb,
	}))

	return
}
