package main

import (
	"github.com/e154/smart-home-configurator/system/dig"
	"github.com/e154/smart-home-configurator/system/config"
	"github.com/e154/smart-home-configurator/system/graceful_service"
	"github.com/e154/smart-home-configurator/system/logging"
	"github.com/e154/smart-home-configurator/system/server"
	"github.com/e154/smart-home-configurator/system/server/controllers"
)

func BuildContainer() (container *dig.Container) {

	container = dig.New()
	container.Provide(config.ReadConfig)
	container.Provide(graceful_service.NewGracefulService)
	container.Provide(graceful_service.NewGracefulServicePool)
	container.Provide(graceful_service.NewGracefulServiceConfig)
	container.Provide(logging.NewLogrus)
	container.Provide(server.NewServer)
	container.Provide(server.NewServerConfig)
	container.Provide(controllers.NewControllers)

	return
}



