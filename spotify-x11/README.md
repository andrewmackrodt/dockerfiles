# [andrewmackrodt/docker-spotify-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/spotify-x11)

[Spotify](https://www.spotify.com/)  is a digital music service that gives you
access to millions of songs.

## Usage

### docker

Note: `--privileged` is only required to pass through GPU acceleration.

```
docker create \
  --name spotify \
  --privileged \
  --net host \
  --device /dev/snd \
  -v $HOME/.config/spotify:/config \
  -v $HOME/.cache/spotify:/cache \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e XDG_RUNTIME_DIR=/run/user/$(id -u) \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/spotify-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /config` | Spotify config |
| `-v /cache` | Spotify cache |
