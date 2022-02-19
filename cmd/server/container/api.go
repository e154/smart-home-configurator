package container

import (
	"github.com/e154/smart-home-configurator/api"
	m "github.com/e154/smart-home-configurator/models"
)

// NewApiConfig ...
func NewApiConfig(cfg *m.AppConfig) api.Config {
	return api.Config{
		HostPort:    cfg.WebHostPort,
		ApiHostPort: cfg.ApiHttpHostPort,
		Debug:       cfg.Debug,
		Swagger:     cfg.WebSwagger,
	}
}
