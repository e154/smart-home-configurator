package controllers

import (
	"github.com/op/go-logging"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/sessions"
	"encoding/json"
)

var (
	log = logging.MustGetLogger("controllers")
)

type ControllerCommon struct {
}

func NewControllerCommon() *ControllerCommon {
	return &ControllerCommon{
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
		page = "private_base.tpl.html"
		jcu, _ := json.Marshal(userinfo)
		params = gin.H{
			"current_user": string(jcu),
		}
	}
	ctx.HTML(200, page, params)
}
