#FROM resin/armhf-alpine:latest
FROM alpine

RUN apk --no-cache --update upgrade && apk --no-cache \
    add unzip bash wget sqlite ca-certificates curl --update bash && \
    mkdir /config && mkdir /install && \
    rm -rf /var/cache/apk/*

# ADD data /data/

WORKDIR /install
COPY get.sh .
RUN chmod +x ./* && bash /install/get.sh \
  && rm /install/get.sh
