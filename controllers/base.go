package controllers

import (
	"github.com/astaxie/beego"
	"github.com/e154/smart-home-configurator/models"
	"fmt"
	"os"
	"encoding/json"
)

type BaseController struct {
	CommonController
}

func (b *BaseController) Prepare() {

	var access_token string
	if at := b.Ctx.Input.Session("access_token"); at != nil {
		access_token = at.(string)
		b.Data["access_token"] = access_token
	}

	if userinfo := b.Ctx.Input.Session("userinfo"); userinfo != nil {
		user_from_session := userinfo.(*models.User)

		//get current user info
		//-----------------------
		server_url := fmt.Sprintf("%s:%s/api/v1/user/%d", beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"), user_from_session.Id)

		result, err := b.SendRequest(
			"GET",
			server_url,
			[]byte{},
			map[string]string{"access_token": access_token},
		);

		if err == nil {
			curren_user := struct {
				User models.User `json: "user"`
			}{}

			if err = json.Unmarshal(result, &curren_user); err == nil {
				jcu, _ := json.Marshal(curren_user.User)
				b.Data["current_user"] = string(jcu)
			} else {
				fmt.Println(err.Error())
			}

		}
	}

	b.Data["info"] = map[string]string{
		"version": os.Getenv("VERSION"),
		"revision": os.Getenv("REVISION"),
		"revision_url": os.Getenv("REVISION_URL"),
		"generated": os.Getenv("GENERATED"),
		"developers": os.Getenv("DEVELOPERS"),
		"build_number": os.Getenv("BUILD_NUMBER"),
	}

	//b.Data["xsrf_token"] = template.HTML(b.XSRFToken())
	b.Data["domen"] = beego.AppConfig.String("domen")
	b.Data["server_url"] = fmt.Sprintf("%s:%s",beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"))
	b.Data["debug"] = beego.AppConfig.String("runmode") == "dev"
	b.Data["language"] = beego.AppConfig.String("language")
}