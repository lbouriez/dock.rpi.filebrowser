FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN [ "cross-build-start" ]

RUN apk --no-cache --update upgrade && apk --no-cache add unzip git bash curl wget sqlite ca-certificates bash openssh && \
    mkdir /data && \
    wget  https://github.com/midaug/rpi-filebrowser/archive/master.zip /data/ && \
    unzip -o -d /data/ /data/master.zip && mv /data/rpi-filebrowser-master /data && \
    rm /data/master.zip && bash /data/get.sh

RUN [ "cross-build-end" ]

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
