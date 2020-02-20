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

**† NVidia driver note**

libnvidia-gl-390 is provided in the image, being the current supported version
in the latest Ubuntu LTS release. The host driver version will be checked every
time the container is started and if there is a version mismatch, an attempt
to install the correct driver in the container will be made unless:

1. Any of the following directories are present: `/usr/local/nvidia/lib`,
   `/usr/local/nvidia/lib64` or `/nvidia`. It is assumed that the correct
   libraries are mounted from the host. Directories will be added to
   `/etc/ld.so.conf.d/nvidia.conf`.
2. The environment variable `NVIDIA_SKIP_DOWNLOAD=1` has been set.
3. The installed driver matches the host `/proc/driver/nvidia/version`.

The first option is the preferred way to add NVidia drivers to the container.
See [here][gist] for an example on generating the required files on the host.
It may also be possible to achieve this using [nvidia-docker][nvidia-docker].

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8
[nvidia-docker]: https://github.com/NVIDIA/nvidia-docker

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
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /games` | Yaba Sanshiro games directory |
| `-v /saves` | Yaba Sanshiro save states |
| `-v /config` | Yaba Sanshiro config |
