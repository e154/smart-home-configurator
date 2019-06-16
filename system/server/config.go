package server

import (
	"github.com/e154/smart-home-configurator/system/config"
)

type ServerConfig struct {
	Host           string
	Port           int
	RunMode        config.RunMode
	MemStorySecret string
	SessionStory   string
}

func NewServerConfig(cfg *config.AppConfig) *ServerConfig {
	return &ServerConfig{
		Host:           cfg.Httpaddr,
		Port:           cfg.Httpport,
		RunMode:        cfg.Runmode,
		MemStorySecret: cfg.MemStorySecret,
		SessionStory:   cfg.SessionStory,
	}
}
