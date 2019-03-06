FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN apk --no-cache --update upgrade && apk --no-cache add unzip bash wget sqlite ca-certificates  && \
    mkdir /data
WORKDIR /data
COPY get.sh .
RUN chmod +x ./* && bash /data/get.sh \
  && rm /data/get.sh

VOLUME /data
EXPOSE 80

ENTRYPOINT ["filebrowser", "--config", "/data/conf/config.json"]
