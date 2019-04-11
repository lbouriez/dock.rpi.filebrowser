#FROM resin/armhf-alpine:latest
FROM alpine:latest

RUN apk --no-cache --update upgrade && apk --no-cache \
    add unzip bash wget sqlite ca-certificates curl && \
    mkdir /config && mkdir /install && \
    rm -rf /var/cache/apk/*

WORKDIR /install
COPY get.sh .
RUN chmod +x ./* && bash /install/get.sh \
  && rm /install/get.sh
