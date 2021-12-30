package container

import (
	v1 "github.com/e154/smart-home-configurator/api/v1"
	m "github.com/e154/smart-home-configurator/models"
)

// NewApiConfig ...
func NewApiConfig(cfg *m.AppConfig) v1.Config {
	return v1.Config{
		HostPort:    cfg.WebHostPort,
		ApiHostPort: cfg.ApiHttpHostPort,
		Debug:       cfg.Debug,
		Swagger:     cfg.WebSwagger,
	}
}
