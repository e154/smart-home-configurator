FROM golang:1.18 as build
RUN update-ca-certificates
MAINTAINER Filippov Alex <support@e154.ru>

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /etc/passwd /etc/passwd
ENTRYPOINT ["/configurator"]
USER nobody
ADD . /

EXPOSE 8080

ENV WEB_HOST_PORT=":8080"
ENV API_HTTP_HOST_PORT="http://localhost:3001"
ENV API_GRPC_HOST_PORT="localhost:3000"
ENV API_WS_HOST_PORT="localhost:3003"
ENV WEB_SWAGGER="true"
ENV DEBUG="true"

VOLUME $APP_DIR/conf
