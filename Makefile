.PHONY: get_deps fmt
.DEFAULT_GOAL := build
build: get_deps build_server build_public
tests: lint test
all: build build_structure build_archive docker_image
deploy: docker_image_upload

EXEC=configurator
CLI=cli
ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TMP_DIR = ${ROOT}/tmp/${EXEC}
ARCHIVE=smart-home-${EXEC}.tar.gz

PROJECT ?=github.com/e154/smart-home-configurator
TRAVIS_BUILD_NUMBER ?= local
HOME ?= ${ROOT}

REV_VALUE=$(shell git rev-parse HEAD 2> /dev/null || echo "???")
REV_URL_VALUE=https://${PROJECT}/commit/${REV_VALUE}
GENERATED_VALUE=$(shell date -u +'%Y-%m-%dT%H:%M:%S%z')
DEVELOPERS_VALUE=delta54<support@e154.ru>
BUILD_NUMBER_VALUE=$(shell echo ${TRAVIS_BUILD_NUMBER})

IMAGE=smart-home-${EXEC}
DOCKER_ACCOUNT=e154
DOCKER_IMAGE_VER=${DOCKER_ACCOUNT}/${IMAGE}:${RELEASE_VERSION}
DOCKER_IMAGE_LATEST=${DOCKER_ACCOUNT}/${IMAGE}:latest

VERSION_VAR=${PROJECT}/version.VersionString
REV_VAR=${PROJECT}/version.RevisionString
REV_URL_VAR=${PROJECT}/version.RevisionURLString
GENERATED_VAR=${PROJECT}/version.GeneratedString
DEVELOPERS_VAR=${PROJECT}/version.DevelopersString
BUILD_NUMBER_VAR=${PROJECT}/version.BuildNumString
DOCKER_IMAGE_VAR=${PROJECT}/version.DockerImageString
GO_BUILD_LDFLAGS= -X ${VERSION_VAR}=${RELEASE_VERSION} -X ${REV_VAR}=${REV_VALUE} -X ${REV_URL_VAR}=${REV_URL_VALUE} -X ${GENERATED_VAR}=${GENERATED_VALUE} -X ${DEVELOPERS_VAR}=${DEVELOPERS_VALUE} -X ${BUILD_NUMBER_VAR}=${BUILD_NUMBER_VALUE} -X ${DOCKER_IMAGE_VAR}=${DOCKER_IMAGE_VER}
GO_BUILD_FLAGS= -a -installsuffix cgo -v --ldflags '${GO_BUILD_LDFLAGS}'
GO_BUILD_ENV= CGO_ENABLED=0
GO_BUILD_TAGS= -tags 'production'

test:
	@echo MARK: unit tests
	go test $(go list ./... | grep -v /tests/)
	go test -race $(go list ./... | grep -v /tests/)

install_linter:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $$(go env GOPATH)/bin v1.42.1

lint-todo:
	@echo MARK: make lint todo

lint:
	golangci-lint run ./...

get_deps:
	go mod tidy

cmd:
	@echo MARK: update comments
	@gocmt -i -d .

build_server:
	@echo MARK: build configurator
	${GO_BUILD_ENV} GOOS=linux GOARCH=amd64 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-linux-amd64
	${GO_BUILD_ENV} GOOS=linux GOARCH=arm GOARM=7 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-linux-arm-7
	${GO_BUILD_ENV} GOOS=linux GOARCH=arm GOARM=6 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-linux-arm-6
	${GO_BUILD_ENV} GOOS=linux GOARCH=arm GOARM=5 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-linux-arm-5
	${GO_BUILD_ENV} GOOS=darwin GOARCH=amd64 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-darwin-10.6-amd64
	${GO_BUILD_ENV} GOOS=darwin GOARCH=arm64 go build ${GO_BUILD_FLAGS} ${GO_BUILD_TAGS} -o ${ROOT}/${EXEC}-darwin-10.6-arm64

build_public:
	@echo MARK: build public
	echo -e "node version.\n"  && \
	node -v  && \
	echo -e "npm version.\n"  && \
	npm -v  && \
	cd ${ROOT}/static_source/public && \
	npm i && \
	npm run build:prod && \
	rm -rf ${ROOT}/build/public && \
	mkdir -p ${ROOT}/build && \
	mv ${ROOT}/static_source/public/dist ${ROOT}/build/public

build_structure:
	@echo MARK: create app structure
	mkdir -p ${TMP_DIR}
	cd ${TMP_DIR}
	cp -r ${ROOT}/build ${TMP_DIR}
	cp -r ${ROOT}/conf ${TMP_DIR}
	cp ${ROOT}/LICENSE ${TMP_DIR}
	cp ${ROOT}/README* ${TMP_DIR}
	cp ${ROOT}/contributors.txt ${TMP_DIR}
	cp ${ROOT}/bin/docker/Dockerfile ${TMP_DIR}
	cp ${ROOT}/${EXEC}-linux-amd64 ${TMP_DIR}
	cp ${ROOT}/${EXEC}-linux-arm-7 ${TMP_DIR}
	cp ${ROOT}/${EXEC}-linux-arm-6 ${TMP_DIR}
	cp ${ROOT}/${EXEC}-linux-arm-5 ${TMP_DIR}
	cp ${ROOT}/${EXEC}-darwin-10.6-amd64 ${TMP_DIR}
	cp ${ROOT}/${EXEC}-darwin-10.6-arm64 ${TMP_DIR}
	cp ${ROOT}/bin/configurator ${TMP_DIR}

build_archive:
	@echo MARK: build app archive
	cd ${TMP_DIR} && ls -l && tar -zcf ${HOME}/${ARCHIVE} .

svgo:
	DIR=${ROOT}/data/icons/*
	cd ${ROOT} && svgo ${DIR} --enable=inlineStyles  --config '{ "plugins": [ { "inlineStyles": { "onlyMatchedOnce": false } }] }' --pretty


client:
	@echo "Building protobuf files"
	cd ${ROOT}/system/client/protos && \
	mkdir -p ${ROOT}/system/client/stub && \
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0/third_party/googleapis \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.5.0/protoc-gen-openapiv2 \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0 \
		--go_out=${ROOT}/system/client/stub --go_opt=paths=source_relative \
		*.proto

	@echo "Building grpc client"
	cd ${ROOT}/system/client/protos && \
	mkdir -p ${ROOT}/system/client/stub && \
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0/third_party/googleapis \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.5.0/protoc-gen-openapiv2 \
		-I${GOPATH}/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0 \
		--go-grpc_out=${ROOT}/system/client/stub --go-grpc_opt=paths=source_relative \
		*.proto

front_client:
	@echo MARK: generate front client lib
	npx swagger-typescript-api@12.0.4 --axios -p ./conf/swagger/api.swagger.yml -o ./static_source/public/src/api -n stub_new.ts

lint:
	golangci-lint run ./...

fmt:
	@gofmt -l -w -s .
	@goimports -w .

docker_image:
	cd ${TMP_DIR} && ls -ll && docker build -f ${ROOT}/bin/docker/Dockerfile -t ${DOCKER_ACCOUNT}/${IMAGE} .

docker_image_upload:
	#echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
	docker tag ${DOCKER_ACCOUNT}/${IMAGE} ${DOCKER_IMAGE_VER}
	echo -e "docker tag ${DOCKER_ACCOUNT}/${IMAGE} ${DOCKER_IMAGE_LATEST}"
	docker tag ${DOCKER_ACCOUNT}/${IMAGE} ${DOCKER_IMAGE_LATEST}
	docker push ${DOCKER_IMAGE_VER}
	docker push ${DOCKER_IMAGE_LATEST}

clean:
	@echo MARK: clean
	rm -rf ${TMP_DIR}
	rm -rf ${ROOT}/build
	rm -f ${ROOT}/${EXEC}-linux-amd64
	rm -f ${ROOT}/${EXEC}-linux-arm-7
	rm -f ${ROOT}/${EXEC}-linux-arm-6
	rm -f ${ROOT}/${EXEC}-linux-arm-5
	rm -f ${ROOT}/${EXEC}-darwin-10.6-amd64
	rm -f ${ROOT}/${EXEC}-darwin-10.6-arm64
	rm -f ${HOME}/${ARCHIVE}
