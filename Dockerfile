FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN [ "cross-build-start" ]

RUN apk --no-cache --update upgrade && apk --no-cache add unzip git bash curl wget sqlite ca-certificates bash openssh && \
    wget  https://github.com/midaug/rpi-filebrowser/archive/master.zip /tmp/ && \
    unzip -o -d /tmp/ /tmp/master.zip && mv /tmp/rpi-filebrowser-master /data && \
    bash /data/get.sh

RUN [ "cross-build-end" ]

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
