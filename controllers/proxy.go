package controllers

import (
	"github.com/astaxie/beego"
	"fmt"
	"net/http"
	"io"
	"net/url"
	"github.com/e154/smart-home-configurator/websocketproxy"
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

	u := fmt.Sprintf("http://%s:%s%s", beego.AppConfig.String("serveraddr"), beego.AppConfig.String("serverport"), r.RequestURI)
	if req, err = http.NewRequest(r.Method, u, r.Body); err != nil {
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

func (w *ProxyController) Ws() {

	var err error

	// get access_token
	var u *url.URL
	if u, err = url.Parse(w.Ctx.Input.URI()); err != nil {
		return
	}

	var m url.Values
	if m, err = url.ParseQuery(u.RawQuery); err != nil {
		return
	}

	if len(m["access_token"]) == 0 || m["access_token"][0] == "" {
		w.ErrHan(500, err.Error())
		return
	}

	var addr string = fmt.Sprintf("%s:%s",
		beego.AppConfig.String("serveraddr"),
		beego.AppConfig.String("serverport"),
	)
	u2 := &url.URL{Scheme: "ws", Host: addr, Path: fmt.Sprintf("/api/v1/ws?access_token=%s", m["access_token"][0])}

	websocketproxy.NewProxy(u2).ServeHTTP(w.Ctx.ResponseWriter, w.Ctx.Request)
}