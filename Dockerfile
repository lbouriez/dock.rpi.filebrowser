FROM resin/armhf-alpine:latest

RUN apk --no-cache --update upgrade && apk --no-cache add unzip bash wget sqlite ca-certificates  && \
    mkdir /data && mkdir /install

ADD data /data/

WORKDIR /install
COPY get.sh .
RUN chmod +x ./* && bash /install/get.sh \
  && rm /install/get.sh && ls /data

ENTRYPOINT ["filebrowser", "--config", "/data/config.json"]
