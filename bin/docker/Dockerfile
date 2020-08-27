FROM debian
MAINTAINER Filippov Alex <af@suretly.com>

ENV APP_DIR /opt/smart-home-configurator
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install ca-certificates -y \
    && mkdir -p $APP_DIR

WORKDIR $APP_DIR

ADD . $APP_DIR

ENTRYPOINT (cd $APP_DIR && ./configurator)

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