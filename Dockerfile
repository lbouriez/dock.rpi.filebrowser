FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN [ "cross-build-start" ]

RUN apk --no-cache --update upgrade && apk --no-cache add git bash curl wget sqlite ca-certificates bash openssh && \
    mkdir /data && \
    git clone git@github.com:midaug/rpi-filebrowser.git /data && \
    bash /data/get.sh

RUN [ "cross-build-end" ]

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
