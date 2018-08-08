FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN [ "cross-build-start" ]

RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates git curl wget && \
    curl -fsSL https://raw.githubusercontent.com/midaug/rpi-filebrowser/master/get.sh | bash

RUN mkdir -p /data/conf && mkdir -p /data/db && mkdir -p /data/srv  && \
    wget --no-check-certificate https://raw.githubusercontent.com/midaug/rpi-filebrowser/master/config.json /data/conf

RUN [ "cross-build-end" ]

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
