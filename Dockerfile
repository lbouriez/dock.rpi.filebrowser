FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN apk --no-cache --update upgrade && apk --no-cache add unzip bash wget sqlite ca-certificates  && \
    mkdir /data && \
    wget --no-check-certificate https://github.com/midaug/rpi-filebrowser/archive/master.zip -P /data/ && \
    unzip -o -d /data/ /data/master.zip && mv /data/rpi-filebrowser-master/* /data/ && \
    chmod 0755 /data/srv/get.sh && \
    rm /data/master.zip && bash /data/srv/get.sh

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
