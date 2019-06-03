# [andrewmackrodt/docker-yabasanshiro-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/yabasanshiro-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fyabasanshiro-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/yabasanshiro-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/yabasanshiro-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/yabasanshiro-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/yabasanshiro-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/yabasanshiro-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/yabasanshiro-x11
[layers]: https://microbadger.com/images/andrewmackrodt/yabasanshiro-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/yabasanshiro-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/yabasanshiro-x11/tags

[Yaba Sanshiro](http://www.uoyabause.org/) _(uoYabause)_ is an unofficial port
of Yabause SEGA Saturn Emulator.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

† libnvidia-gl-390 is installed, see [here][gist] if you have a different
proprietary NVidia driver installed on how to mount the correct drivers to
the container without requiring an image rebuild.

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8

## Usage

**Security Notice:** container requires running with `--privileged` or you will
not get acceptable framerates. If anyone knows why this is the case, please
raise an issue. Mounting all device node from /dev, adding the ALL system
capability and running apparmor as unconfined do not help.

### docker

```
# get the xdg runtime dir
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# create the container
docker create \
  --name yabause \
  --privileged \
  --net host \
  --shm-size 128M \
  -v $HOME/Games/Saturn:/games \
  -v $HOME/.yabause/saves:/saves \
  -v $HOME/.yabause/config:/config \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse:ro \
  -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
  -v /var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro \
  -v /run/dbus:/run/dbus:ro \
  -v /run/udev/data:/run/udev/data:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/yabasanshiro-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /games` | Yaba Sanshiro games directory |
| `-v /saves` | Yaba Sanshiro save states |
| `-v /config` | Yaba Sanshiro config |
