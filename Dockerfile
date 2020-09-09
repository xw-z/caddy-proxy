FROM golang:1.15 as builder
LABEL AUTHOR="xwzhou@yeah.net"

ENV GO111MODULE=on
#ENV GOPROXY=https://goproxy.cn,direct

WORKDIR /app

RUN go get github.com/jwilder/docker-gen/...@v0.0.0-20180114214846-6455e0c860fd
RUN go get github.com/ddollar/forego@v0.16.2-0.20191115132403-51d9f6dc5ffb

COPY . /app/

RUN go build -v -o ./caddy ./app/caddy


FROM golang:1.15
WORKDIR /app

COPY --from=builder /go/bin/docker-gen /bin/docker-gen 
COPY --from=builder /go/bin/forego /bin/forego
COPY --from=builder /app/caddy /bin/caddy
COPY --from=builder /app/Procfile /app/Procfile
COPY --from=builder /app/Caddyfile.tmpl /app/Caddyfile.tmpl



RUN printf ":80\n" > /etc/Caddyfile


ENTRYPOINT [ "forego", "start", "-r" ]

EXPOSE 80 443
