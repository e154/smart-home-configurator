
ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TMP_DIR = ${ROOT}/tmp
CONF_DIR = ${ROOT}/conf

client:
	@echo MARK: generate client stub
	cd ${ROOT}/system/client/protos && \
	mkdir -p ${ROOT}/system/client/stub && \
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0/third_party/googleapis \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.5.0/protoc-gen-openapiv2 \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0 \
		--go_out=${ROOT}/system/client/stub --go_opt=paths=source_relative \
		--go-grpc_out=${ROOT}/system/client/stub --go-grpc_opt=paths=source_relative \
		*.proto

front_client:
	@echo MARK: generate front client lib
	npx swagger-typescript-api --axios -p ./conf/swagger/api.swagger.yml -o ./static_source/public/src/api -n stub.ts

server:
	@echo MARK: generate server stub
	mkdir -p ${ROOT}/api/v1/stub
	oapi-codegen -generate server ${CONF_DIR}/swagger/api.swagger.yml > api/v1/stub/server.go
	oapi-codegen -generate types ${CONF_DIR}/swagger/api.swagger.yml > api/v1/stub/types.go

lint:
	golangci-lint run ./...

fmt:
	@gofmt -l -w -s .
	@goimports -w .
