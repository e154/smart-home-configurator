package controllers

import (
	"github.com/gin-gonic/gin"
)

type ControllerProxy struct {
	*ControllerCommon
}

func NewControllerProxy(common *ControllerCommon) *ControllerProxy {
	return &ControllerProxy{ControllerCommon: common}
}

func (i ControllerProxy) Index(c *gin.Context) {

	return
}

func (i ControllerProxy) Simple(c *gin.Context) {

	return
}

func (i ControllerProxy) Upload(c *gin.Context) {

	return
}

func (i ControllerProxy) Ws(c *gin.Context) {

	return
}

