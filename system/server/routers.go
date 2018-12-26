package server

import (
	"html/template"
	"reflect"
	"strings"
	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-contrib/sessions/memstore"
	"github.com/gin-contrib/sessions"
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
	method := ctx.Request.Method
	log.Infof("path %s, meth(%s)", r, method)

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
	case r == "/upload":
		s.Controllers.Proxy.Simple(ctx)
	case strings.Contains(r, "/api/v1/ws"):
		s.Controllers.Proxy.Ws(ctx)
	case strings.Contains(r, "/api/v1"):
		s.Controllers.Proxy.Simple(ctx)
	case strings.Contains(r, "/api/v1/image/upload"):
		s.Controllers.Proxy.Upload(ctx)
	default:
		s.Controllers.Index.Index(ctx)
	}
}
