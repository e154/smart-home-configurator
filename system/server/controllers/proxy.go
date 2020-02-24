// This file is part of the Smart Home
// Program complex distribution https://github.com/e154/smart-home
// Copyright (C) 2016-2020, Filippov Alex
//
// This library is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Library General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library.  If not, see
// <https://www.gnu.org/licenses/>.

package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"fmt"
	"io"
	"net/url"
	"github.com/e154/smart-home-configurator/system/websocketproxy"
	"github.com/parnurzeal/gorequest"
	"bytes"
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

	form, _ := ctx.MultipartForm()

	if len(form.File) == 0 {
		ctx.AbortWithError(403, fmt.Errorf("http: no such file"))
		return
	}

	r := ctx.Request

	// destination server url
	u := fmt.Sprintf("%s://%s:%d%s", i.cfg.ApiScheme, i.cfg.ApiAddr, i.cfg.ApiPort, ctx.Request.RequestURI)
	request := gorequest.New().Post(u).Type("multipart")
	for k, value := range r.Header {
		if k == "Access_token" {
			request.Set(k, value[0])
		}
	}

	for k, file := range form.File {

		for _, f := range file {
			r, err := f.Open()
			if err != nil {
				ctx.AbortWithError(403, err)
				return
			}
			defer r.Close()

			buf := bytes.NewBuffer(nil)
			if _, err := io.Copy(buf, r); err != nil {
				ctx.AbortWithError(403, err)
				return
			}

			request = request.SendFile(buf.Bytes(), f.Filename, k)
		}
	}

	_, _, errs := request.End()
	for _, err := range errs {
		ctx.AbortWithError(403, err)
	}

	return
}

func (i ControllerProxy) Ws(ctx *gin.Context) {

	var err error

	// get access_token
	var u *url.URL
	if u, err = url.Parse(ctx.Request.RequestURI); err != nil {
		return
	}

	var m url.Values
	if m, err = url.ParseQuery(u.RawQuery); err != nil {
		return
	}

	if len(m["access_token"]) == 0 || m["access_token"][0] == "" {
		ctx.AbortWithError(500, err)
		return
	}

	addr := fmt.Sprintf("%s:%d", i.cfg.ApiAddr, i.cfg.ApiPort)
	u2 := &url.URL{Scheme: "ws", Host: addr, Path: fmt.Sprintf("/api/v1/ws?access_token=%s", m["access_token"][0])}

	websocketproxy.NewProxy(u2).ServeHTTP(ctx.Writer, ctx.Request)

	return
}
