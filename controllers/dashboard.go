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
		//h.Token = "Basic " + auth[1]

		server_url := fmt.Sprintf("%s:%s/api/v1/signin", beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"))
		result, err := h.SendRequest(
			"GET",
			server_url,
			[]byte{},
			map[string]string{"Authorization": "Basic " + auth[1]},
		)
		if err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		message := struct {
			Status	string	`json:"status"`
			Message	string	`json:"message"`
		}{}

		if err = json.Unmarshal(result, &message); err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		if message.Status != "" && message.Status == "error" {
			h.ErrHan(403, message.Message)
			return
		}

		current := struct {
			Token	string			`json:"access_token"`
			User	*models.User	`json:"current_user"`
		}{}

		if err = json.Unmarshal(result, &current); err != nil {
			h.ErrHan(403, err.Error())
			return
		}

		if current.User != nil {
			h.SetSession("userinfo", current.User)
			h.SetSession("access_token", current.Token)
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