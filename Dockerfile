FROM resin/armhf-alpine:latest
MAINTAINER blog.midaug.win

RUN [ "cross-build-start" ]

ENV VERSION 1.9.0

ADD https://github.com/filebrowser/filebrowser/releases/download/v${VERSION}/linux-armv7-filebrowser.tar.gz /usr/local/bin/dep/filebrowser.tar.gz

COPY . /go/src/github.com/filebrowser/filebrowser

WORKDIR /go/src/github.com/filebrowser/filebrowser
RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates git curl && \
  tar -xzvf /usr/local/bin/dep/filebrowser.tar.gz -C /usr/local/bin/dep \
  rm /usr/local/bin/dep/filebrowser.tar.gz \
  chmod +x /usr/local/bin/dep
RUN dep ensure -vendor-only

WORKDIR /go/src/github.com/filebrowser/filebrowser/cmd/filebrowser
RUN CGO_ENABLED=0 go build -a
RUN mv filebrowser /go/bin/filebrowser

FROM scratch
COPY --from=0 /go/bin/filebrowser /filebrowser
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

RUN [ "cross-build-end" ]

VOLUME /tmp
VOLUME /srv
EXPOSE 80

COPY Docker.json /config.json

ENTRYPOINT ["/filebrowser", "--config", "/config.json"]
