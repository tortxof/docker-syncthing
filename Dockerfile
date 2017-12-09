FROM alpine

RUN apk add --no-cache wget ca-certificates

WORKDIR /app

RUN wget https://github.com/syncthing/syncthing/releases/download/v0.14.41/syncthing-linux-amd64-v0.14.41.tar.gz

RUN tar -xvf syncthing-linux-amd64-v0.14.41.tar.gz

FROM busybox

WORKDIR /app

RUN addgroup -S syncthing && \
    adduser -D -S -h /app -G syncthing syncthing

USER syncthing

COPY --from=0 /app/syncthing-linux-amd64-v0.14.41/syncthing .

CMD ["./syncthing", "-no-browser", "-gui-address=0.0.0.0:8384", "-home=/app/config"]
