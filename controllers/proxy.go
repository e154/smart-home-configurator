package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"net/http"
	"io"
)

type ProxyController struct {
	BaseController
}

// URLMapping ...
func (h *ProxyController) URLMapping() {
	h.Mapping("Simple", h.Simple)
}

func (h *ProxyController) Simple() {

	var err error
	var r, req *http.Request
	var resp *http.Response
	r = h.Ctx.Request
	wr := h.Ctx.ResponseWriter

	url := fmt.Sprintf("%s:%s/%s", beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"), r.RequestURI)
	if req, err = http.NewRequest(r.Method, url, r.Body); err != nil {
		h.ErrHan(500, err.Error())
		return
	}

	for name, value := range r.Header {
		req.Header.Set(name, value[0])
	}

	defer req.Body.Close()

	// resend request
	client := &http.Client{}
	if resp, err = client.Do(req); err != nil {
		h.ErrHan(500, err.Error())
		return
	}

	defer resp.Body.Close()

	// write result
	for k, v := range resp.Header {
		wr.Header().Set(k, v[0])
	}

	wr.WriteHeader(resp.StatusCode)
	io.Copy(wr, resp.Body)
}