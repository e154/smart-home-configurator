package controllers

type Controllers struct {
	Index *ControllerIndex
	Proxy *ControllerProxy
}

func NewControllers() *Controllers {
	common := NewControllerCommon()
	return &Controllers{
		Index: NewControllerIndex(common),
		Proxy: NewControllerProxy(common),
	}
}
