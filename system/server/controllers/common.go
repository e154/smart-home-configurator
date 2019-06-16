package controllers

import (
	"github.com/op/go-logging"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/sessions"
	"encoding/json"
	"net/http"
	"crypto/tls"
	"github.com/parnurzeal/gorequest"
	"github.com/e154/smart-home-configurator/system/config"
	m "github.com/e154/smart-home-configurator/models"
	"fmt"
	"os"
)

var (
	log = logging.MustGetLogger("controllers")
)

type ControllerCommon struct {
	cfg *config.AppConfig
}

func NewControllerCommon(cfg *config.AppConfig) *ControllerCommon {
	return &ControllerCommon{
		cfg: cfg,
	}
}

func (c ControllerCommon) query(ctx *gin.Context, query string) string {
	return ctx.Request.URL.Query().Get(query)
}

func (c *ControllerCommon) showPage(ctx *gin.Context) {

	method := ctx.Request.Method

	switch method {
	case "GET":
	default:
		return
	}

	session := sessions.Default(ctx)
	userinfo := session.Get("userinfo")

	params := gin.H{}
	page := "public_base.tpl.html"
	if userinfo != nil {
		accessToken := session.Get("access_token")
		user := userinfo.(*m.User)
		page = "private_base.tpl.html"
		jcu, _ := json.Marshal(userinfo)
		params = gin.H{
			"current_user": string(jcu),
			"access_token": accessToken,
			"debug":        c.cfg.Runmode == config.DebugMode,
			"language":     user.Lang,
			"server_url":   fmt.Sprintf("%s://%s:%d", c.cfg.ApiScheme, c.cfg.ApiAddr, c.cfg.ApiPort),
			"info": map[string]string{
				"version":      os.Getenv("VERSION"),
				"revision":     os.Getenv("REVISION"),
				"revision_url": os.Getenv("REVISION_URL"),
				"generated":    os.Getenv("GENERATED"),
				"developers":   os.Getenv("DEVELOPERS"),
				"build_number": os.Getenv("BUILD_NUMBER"),
			},
		}
	}
	ctx.HTML(200, page, params)
}

func (c *ControllerCommon) IsAjax(ctx *gin.Context) bool {
	return ctx.Request.Header.Get("X-Requested-With") == "XMLHttpRequest"
}

func (c ControllerCommon) getAgent() *gorequest.SuperAgent {

	req := gorequest.New()
	req.Transport = &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	return req
}
