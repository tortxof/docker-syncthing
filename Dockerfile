FROM ubuntu:trusty
MAINTAINER Daniel Jones <tortxof@gmail.com>

RUN groupadd -r app && useradd -r -g app app && \
    mkdir /home/app && \
    chown app:app /home/app

ADD https://github.com/syncthing/syncthing/releases/download/v0.11.20/syncthing-linux-amd64-v0.11.20.tar.gz /
RUN tar -xzf syncthing-linux-amd64-v0.11.20.tar.gz && \
    rm syncthing-linux-amd64-v0.11.20.tar.gz && \
    mv /syncthing-linux-amd64-v0.11.20 /app && \
    chown -R app:app /app

WORKDIR /home/app

USER app

EXPOSE 8384 22000

VOLUME ["/home/app/.config/syncthing", "/home/app/Sync"]

CMD ["/app/syncthing"]
