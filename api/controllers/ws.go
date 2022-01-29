package controllers

import (
	"fmt"
	"github.com/e154/smart-home-configurator/system/websocketproxy"
	"github.com/labstack/echo/v4"
	"net/http"
	"net/url"
)

// ControllerWs ...
type ControllerWs struct {
	*ControllerCommon
}

// NewWsController ...
func NewWsController(common *ControllerCommon,
) *ControllerWs {
	return &ControllerWs{
		ControllerCommon: common,
	}
}

func (c *ControllerWs) Ws(ctx echo.Context) error {

	var err error

	// get access_token
	var u *url.URL
	if u, err = url.Parse(ctx.Request().RequestURI); err != nil {
		return echo.NewHTTPError(http.StatusUnauthorized, "Please provide valid credentials")
	}

	var m url.Values
	if m, err = url.ParseQuery(u.RawQuery); err != nil {
		return echo.NewHTTPError(http.StatusUnauthorized, "Please provide valid credentials")
	}

	if len(m["access_token"]) == 0 || m["access_token"][0] == "" {
		return echo.NewHTTPError(http.StatusInternalServerError, "Please provide valid credentials")
	}

	u2 := &url.URL{Scheme: "ws", Host: c.config.ApiWsHostPort, Path: fmt.Sprintf("/ws?access_token=%s", m["access_token"][0])}

	websocketproxy.NewProxy(u2).ServeHTTP(ctx.Response().Writer, ctx.Request())

	return nil
}
