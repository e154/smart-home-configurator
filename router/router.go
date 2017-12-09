package router

import (
	"github.com/astaxie/beego"
	"github.com/e154/smart-home-configurator/controllers"
)

func Initialize() {
	beego.ErrorController(&controllers.ErrorController{})

	beego.Router("/", &controllers.DashboardController{}, "*:Index")
	beego.Router("/signin", &controllers.DashboardController{}, "*:Signin")
	beego.Router("/signout", &controllers.DashboardController{}, "get:Signout")
	beego.Router("/recovery", &controllers.DashboardController{}, "post:Recovery")
	beego.Router("/reset", &controllers.DashboardController{}, "post:Reset")
	beego.Router("/api/*", &controllers.ProxyController{}, "*:Simple")
	beego.Router("/upload/*", &controllers.ProxyController{}, "*:Simple")
	beego.Router("/*", &controllers.DashboardController{}, "*:Index")
}