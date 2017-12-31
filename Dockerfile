FROM alpine

RUN apk add --no-cache curl jq gnupg ca-certificates \
    && gpg --keyserver keyserver.ubuntu.com --recv-key D26E6ED000654A3E

ENV release=

RUN set -x \
    && mkdir /syncthing \
    && cd /syncthing \
    && release=${release:-$(curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq -r .tag_name )} \
    && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/syncthing-linux-amd64-${release}.tar.gz \
    && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/sha256sum.txt.asc \
    && gpg --verify sha256sum.txt.asc \
    && grep syncthing-linux-amd64 sha256sum.txt.asc | sha256sum \
    && tar -zxf syncthing-linux-amd64-${release}.tar.gz \
    && mv syncthing-linux-amd64-${release}/syncthing .

FROM busybox

WORKDIR /app

RUN addgroup -S syncthing && \
    adduser -D -S -h /app -G syncthing syncthing

USER syncthing

ENV STNOUPGRADE=1

COPY --from=0 /syncthing/syncthing .

CMD ["./syncthing", "-no-browser", "-gui-address=0.0.0.0:8384", "-home=/app/config"]
