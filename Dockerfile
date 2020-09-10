FROM golang:1.14 as builder
LABEL AUTHOR="xwzhou@yeah.net"

ENV GO111MODULE=on
#ENV GOPROXY=https://goproxy.cn,direct


RUN go get github.com/jwilder/docker-gen/...@v0.0.0-20180114214846-6455e0c860fd
RUN go get github.com/ddollar/forego@v0.16.2-0.20191115132403-51d9f6dc5ffb


WORKDIR /app
COPY . /app/

RUN go build -v -o ./caddy ./app/caddy


FROM debian:buster-slim
LABEL AUTHOR="xwzhou@yeah.net"


WORKDIR /app

COPY --from=builder /bin/sh /bin/sh
COPY --from=builder /go/bin/docker-gen /bin/docker-gen 
COPY --from=builder /go/bin/forego /bin/forego
COPY --from=builder /app/caddy /bin/caddy

COPY ./Procfile /app/Procfile
COPY ./Caddyfile.tmpl /app/Caddyfile.tmpl
COPY ./Caddyfile /etc/Caddyfile


ENTRYPOINT [ "/bin/forego", "start", "-r" ]

EXPOSE 80 443
