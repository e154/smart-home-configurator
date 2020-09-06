package controllers

import (
	"encoding/json"
	"errors"
	m "github.com/e154/smart-home-dashboard/models"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"path/filepath"
	"strings"
)

type ControllerPublic struct {
	*ControllerCommon
	publicIndex *template.Template
	fileServer  http.Handler
}

func NewControllerPublic(common *ControllerCommon) *ControllerPublic {
	return &ControllerPublic{
		ControllerCommon: common,
	}
}

func (p *ControllerPublic) Index(ctx *gin.Context) {

	if p.fileServer == nil {
		fs := static.LocalFile(filepath.Join("build", "public"), false)
		p.fileServer = http.FileServer(fs)
	}

	switch  {
	case strings.Contains(ctx.Request.URL.Path, "."):

		p.fileServer.ServeHTTP(ctx.Writer, ctx.Request)
		ctx.Abort()

	default:

		if p.publicIndex == nil {
			var err error
			p.publicIndex, err = template.ParseFiles(filepath.Join("build", "public", "index.html"))
			if err != nil {
				ctx.AbortWithError(http.StatusInternalServerError, err)
				return
			}
			p.publicIndex.Funcs(p.funcMap())
		}

		p.publicIndex.Execute(ctx.Writer, map[string]interface{}{})
		ctx.Abort()
	}
}

func (p *ControllerPublic) Login(ctx *gin.Context) {

	login := &m.Login{}
	if err := ctx.ShouldBindJSON(login); err != nil {
		log.Error(err.Error())
		ctx.AbortWithError(http.StatusBadRequest, err)
		return
	}

	uri := p.getApiEndpoint(p.cfg.BasePath + "/signin")
	r, body, errs := p.getAgent().
		Post(uri).
		SetBasicAuth(login.Email, login.Password).
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

	session := sessions.Default(ctx)
	session.Set("userinfo", current.User)
	session.Set("access_token", current.Token)
	session.Save()

	ctx.JSON(200, gin.H{
		"data": gin.H{
			"token": current.Token,
		},
	})
}

func (p *ControllerPublic) ResetPassword(ctx *gin.Context) {
	ctx.JSON(200, struct {
	}{})
}

func (p *ControllerPublic) RequestPassword(ctx *gin.Context) {
	ctx.JSON(200, struct {
	}{})
}
