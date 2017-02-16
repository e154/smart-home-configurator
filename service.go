package main

import (
	"os"
	"os/signal"
	"syscall"
	"github.com/takama/daemon"
	"github.com/astaxie/beego"
	"github.com/e154/smart-home-configurator/router"
)

const (
	name        = "smart-home-configurator"
	description = "Smart Home Configurator"
)

var dependencies = []string{}

type Service struct {
	daemon.Daemon
}

func (service *Service) Manage() (string, error) {

	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "install":
			return service.Install()
		case "remove":
			return service.Remove()
		case "start":
			return service.Start()
		case "stop":
			return service.Stop()
		case "status":
			return service.Status()
		}
	}

	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, os.Kill, syscall.SIGTERM)

	Initialize()

	var port int
	port = beego.BConfig.Listen.HTTPPort

	for {
		select {
		case killSignal := <-interrupt:
			stdlog.Println("Got signal:", killSignal)
			stdlog.Println("Stoping listening on ", port)

			if killSignal == os.Interrupt {
				return "Configurator was interruped by system signal", nil
			}
			return "Configurator was killed", nil
		}
	}
}

func ServiceInitialize() {
	srv, err := daemon.New(name, description, dependencies...)
	if err != nil {
		errlog.Println("Error: ", err)
		os.Exit(1)
	}
	service := &Service{srv}
	status, err := service.Manage()
	if err != nil {
		errlog.Println(status, "\nError: ", err)
		os.Exit(1)
	}
	stdlog.Println(status)
}

func Initialize() {
	router.Initialize()

	beego.Info("Starting....")
	beego.Info("AppPath:", beego.AppPath)

	data_dir := beego.AppConfig.String("data_dir")

	if(beego.AppConfig.String("runmode") == "dev") {
		beego.Info("Develment mode enabled")

		beego.SetStaticPath("/static", "build/private")
		beego.SetStaticPath("/_static", "build/public")
		beego.SetStaticPath("/attach", data_dir)
	} else {
		beego.Info("Product mode enabled")

		beego.SetStaticPath("/static", "build/private")
		beego.SetStaticPath("/_static", "build/public")
		beego.SetStaticPath("/attach", data_dir)
	}

	go beego.Run()
}