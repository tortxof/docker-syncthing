# docker-syncthing

The config directory in the container is `/app/.config/syncthing`.

Run the container with a volume for the config and one or more volumes for the
shared data. You may also want to run the container with a uid and gid from your
host system.

```
docker run -d --restart always \
  --name syncthing \
  -p 8384:8384 \
  -p 22000:22000 \
  -v /config/dir/on/host:/app/.config/syncthing \
  -v /data/dir/on/host:/data/dir/in/container \
  tortxof/syncthing
```
