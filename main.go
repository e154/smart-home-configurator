package main

import (
	"os"
	"fmt"
	"github.com/op/go-logging"
	"github.com/sirupsen/logrus"
	"github.com/e154/smart-home-configurator/system/graceful_service"
	l "github.com/e154/smart-home-configurator/system/logging"
	"github.com/e154/smart-home-configurator/system/server"
)

var (
	log = logging.MustGetLogger("main")
)

func main() {

	args := os.Args[1:]
	for _, arg := range args {
		switch arg {
		case "-v", "--version":
			fmt.Printf(shortVersionBanner, GetHumanVersion())
			return
		default:
			fmt.Printf(verboseVersionBanner, "v2", os.Args[0])
			return
		}
	}

	start()
}

func start() {

	fmt.Printf(shortVersionBanner, "")

	container := BuildContainer()
	container.Invoke(func(
		graceful *graceful_service.GracefulService,
		lx *logrus.Logger,
		server *server.Server) {
		l.Initialize(lx)
		server.Start()
		graceful.Wait()
	})
}
