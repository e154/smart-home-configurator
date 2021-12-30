package controllers

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

// ControllerIndex ...
type ControllerIndex struct {
	*ControllerCommon
}

// NewIndexController ...
func NewIndexController(common *ControllerCommon,
) *ControllerIndex {
	return &ControllerIndex{
		ControllerCommon: common,
	}
}

func (c *ControllerIndex) Index(ctx echo.Context) error {
	return ctx.Render(http.StatusOK, "index.html", map[string]interface{}{
		"variables": "....",
	})
}
