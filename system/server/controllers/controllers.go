package controllers

import "github.com/e154/smart-home-configurator/system/config"

type Controllers struct {
	Index *ControllerIndex
	Proxy *ControllerProxy
}

func NewControllers(cfg *config.AppConfig) *Controllers {
	common := NewControllerCommon(cfg)
	return &Controllers{
		Index: NewControllerIndex(common),
		Proxy: NewControllerProxy(common),
	}
}
