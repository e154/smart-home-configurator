package controllers

import (
	"fmt"
	"encoding/json"
	"github.com/astaxie/beego"
	"github.com/e154/smart-home-configurator/models"
	"strings"
)

type DashboardController struct {
	BaseController
}

// URLMapping ...
func (c *DashboardController) URLMapping() {
	c.Mapping("Index", c.Index)
	c.Mapping("Signin", c.Signin)
	c.Mapping("Signout", c.Signout)
	c.Mapping("Recovery", c.Recovery)
	c.Mapping("Reset", c.Reset)
}

func (h *DashboardController) Index() {

	userinfo := h.GetSession("userinfo")
	if userinfo == nil {
		h.Ctx.Redirect(302, "/signin")
		return
	}

	h.Layout = h.GetTemplate() + "/private/base.tpl.html"
	h.TplName = h.GetTemplate() + "/private/index.tpl.html"
	h.UpdateTemplate()
}

func (h *DashboardController) Signin() {

	userinfo := h.GetSession("userinfo")
	if userinfo != nil {
		h.Ctx.Redirect(302, "/")
		return
	}

	if isajax := h.Ctx.Input.IsAjax(); isajax {

		auth := strings.SplitN(h.Ctx.Input.Header("Authorization"), " ", 2)
		if len(auth) != 2 || auth[0] != "Basic" {
			h.ErrHan(403, "bad syntax")
			return
		}

		server_url := fmt.Sprintf("%s:%s/api/v1/signin", beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"))
		result, err := h.SignIn("GET", server_url, "Basic " + auth[1])
		if err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		message := &models.Message{}
		if err = json.Unmarshal(result, message); err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		if message.Status != "" && message.Status == "error" {
			h.ErrHan(403, message.Message)
			return
		}

		signin := &models.Signin{}
		if err = json.Unmarshal(result, signin); err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		if signin.User != nil {
			h.SetSession("userinfo", signin.User)
			h.SetSession("access_token", signin.Token)
			h.ServeJSON()
			return
		}

		return
	}

	h.Layout = h.GetTemplate() + "/public/base.tpl.html"
	h.TplName = h.GetTemplate() + "/public/login.tpl.html"
	h.UpdateTemplate()
}

func (h *DashboardController) Signout() {
	h.DelSession("userinfo")
	h.DelSession("access_token")
	h.Ctx.Redirect(302, "/signin")
}

func (h *DashboardController) Recovery() {}

func (h *DashboardController) Reset() {}