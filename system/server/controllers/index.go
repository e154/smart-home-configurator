package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/sessions"
	m "github.com/e154/smart-home-configurator/models"
)

type ControllerIndex struct {
	*ControllerCommon
}

func NewControllerIndex(common *ControllerCommon) *ControllerIndex {
	return &ControllerIndex{ControllerCommon: common}
}

func (i ControllerIndex) Index(c *gin.Context) {

	session := sessions.Default(c)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		c.Redirect(302, "/signin")
		return
	}

	i.showPage(c)

	return
}

func (i ControllerIndex) Signin(c *gin.Context) {

	session := sessions.Default(c)
	userinfo := session.Get("userinfo")
	if userinfo != nil {
		c.Redirect(302, "/")
		return
	}


	i.showPage(c)

	_, _, ok := c.Request.BasicAuth()
	if !ok {
		return
	}

	//...

	//...

	session.Set("userinfo", &m.User{})
	session.Set("access_token", "sometoken")
	session.Save()

	c.JSON(200, &map[string]interface{}{"access_token": "sometoken"})

	return
}

func (i ControllerIndex) Signout(c *gin.Context) {

	session := sessions.Default(c)
	userinfo := session.Get("userinfo")
	if userinfo == nil {
		c.Redirect(302, "/signin")
	}

	session.Delete("userinfo")
	session.Delete("access_token")
	session.Save()

	c.Redirect(302, "/signin")

	return
}

func (i ControllerIndex) Recovery(c *gin.Context) {
	c.JSON(200, struct {

	}{})
	return
}

func (i ControllerIndex) Reset(c *gin.Context) {
	c.JSON(200, struct {

	}{})
	return
}
