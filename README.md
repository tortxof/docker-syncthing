# docker-syncthing

Build the image.

    docker build -t tortxof/syncthing .

Run a container. You'll need to edit the `config.xml` to change the bind address
after the first run.

    docker run -d --restart always --name syncthing -p 8000:8384 -p 22000:22000 tortxof/syncthing

Edit the config.

    docker run -ti --rm --volumes-from syncthing tortxof/util nano /home/app/.config/syncthing/config.xml

Restart the container.

    docker restart syncthing

Create a data container.

    docker create --name syncthing-data --volumes-from syncthing busybox
