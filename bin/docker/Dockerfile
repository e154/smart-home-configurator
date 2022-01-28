FROM golang:1.17 as build
RUN update-ca-certificates
MAINTAINER Filippov Alex <support@e154.ru>

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /etc/passwd /etc/passwd
ENTRYPOINT ["/configurator"]
USER nobody
ADD . /

EXPOSE 8080

ENV HTTP_ADDR="0.0.0.0"
ENV HTTP_PORT="8080"
ENV RUNMODE="debug"
ENV API_ADDR="smart_home_server"
ENV API_PORT="3000"
ENV API_SCHEME="http"
ENV MEM_STORY_SECRET="secret"
ENV SESSION_STORY="mysession"

VOLUME $APP_DIR/conf
