package controllers

import (
	"encoding/json"
	m "github.com/e154/smart-home-dashboard/models"
	"github.com/e154/smart-home-dashboard/system/config"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"path/filepath"
	"strings"
	"time"
)

type ControllerPrivate struct {
	*ControllerCommon
	publicIndex *template.Template
	fileServer  http.Handler
}

func NewControllerPrivate(common *ControllerCommon) *ControllerPrivate {
	return &ControllerPrivate{
		ControllerCommon: common,
	}
}

func (p *ControllerPrivate) Index(ctx *gin.Context, user *m.User) {

	if p.fileServer == nil {
		fs := static.LocalFile(filepath.Join("build", "private"), false)
		p.fileServer = http.FileServer(fs)
	}


	switch  {
	case strings.Contains(ctx.Request.URL.Path, "."):

		p.fileServer.ServeHTTP(ctx.Writer, ctx.Request)
		ctx.Abort()

	default:

		//TODO fix it
		p.publicIndex = nil
		if p.publicIndex == nil {
			var err error
			t := template.New("index.html").Funcs(p.funcMap())
			if p.publicIndex, err = t.ParseFiles(filepath.Join("build", "private", "index.html")); err != nil {
				log.Error(err.Error())
				ctx.AbortWithError(http.StatusInternalServerError, err)
				return
			}
		}

		session := sessions.Default(ctx)
		accessToken := session.Get("access_token")
		jcu, _ := json.Marshal(user)

		err := p.publicIndex.Execute(ctx.Writer, map[string]interface{}{
			"current_user": string(jcu),
			"access_token": accessToken,
			"debug":        p.cfg.Runmode == config.DebugMode,
			"language":     user.Lang,
			"t":            time.Now().Unix(),
		})

		if err != nil {
			log.Error(err.Error())
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}

		ctx.Abort()
	}
}

func (p *ControllerPublic) Logout(ctx *gin.Context) {

	session := sessions.Default(ctx)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		ctx.Redirect(302, "/login")
	}

	session.Delete("userinfo")
	session.Delete("access_token")
	session.Save()

	ctx.Redirect(302, "/login")
}
