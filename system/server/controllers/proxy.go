package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"fmt"
	"io"
)

type ControllerProxy struct {
	*ControllerCommon
}

func NewControllerProxy(common *ControllerCommon) *ControllerProxy {
	return &ControllerProxy{ControllerCommon: common}
}

func (i ControllerProxy) Simple(ctx *gin.Context) {

	var err error
	var r, req *http.Request
	var resp *http.Response
	r = ctx.Request
	wr := ctx.Writer

	u := fmt.Sprintf("%s://%s:%d%s", i.cfg.ApiScheme, i.cfg.ApiAddr, i.cfg.ApiPort, ctx.Request.RequestURI)
	if req, err = http.NewRequest(r.Method, u, r.Body); err != nil {
		ctx.AbortWithError(500, err)
		return
	}

	for name, value := range r.Header {
		req.Header.Set(name, value[0])
	}

	defer req.Body.Close()

	// resend request
	client := &http.Client{}
	if resp, err = client.Do(req); err != nil {
		ctx.AbortWithError(500, err)
		return
	}

	defer resp.Body.Close()

	// write result
	for k, v := range resp.Header {
		wr.Header().Set(k, v[0])
	}


	wr.WriteHeader(resp.StatusCode)
	io.Copy(wr, resp.Body)

	return
}

func (i ControllerProxy) Upload(ctx *gin.Context) {
	log.Info("upload")
	return
}

func (i ControllerProxy) Ws(ctx *gin.Context) {
	log.Info("ws")
	return
}

