# [andrewmackrodt/docker-firefox-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/firefox-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Ffirefox-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/firefox-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/firefox-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/firefox-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/firefox-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/firefox-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/firefox-x11
[layers]: https://microbadger.com/images/andrewmackrodt/firefox-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/firefox-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/firefox-x11/tags

[Firefox](https://www.mozilla.org/en-GB/firefox/new/) is a free and open-source
web browser developed by the Mozilla Foundation and its subsidiary, Mozilla
Corporation.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

† libnvidia-gl-390 is installed; the host driver version will be checked the
first time a container is started and an attempt to install the correct driver
in the container will be made. To skip this behaviour set the environment
variable `NVIDIA_SKIP_DOWNLOAD=1`. It is also possible to mount a volume
containing the drivers contained on the host and use those, see [here][gist]
for an example on how to achieve this.

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8

## Usage

**Security Notice:** the provided config creates a container with the security
option `apparmor:unconfined`. This is required for D-Bus to communicate with
the host for certain operations, e.g. updating the global menu in Unity. If this
is not required, modify the command to remove the security option and remove
the `$XDG_RUNTIME_DIR/bus` volume mount.

Video acceleration, audio and gamepad support will function regardless of the
above settings.

### docker

```
# detect gpu devices to pass through
GPU_DEVICES=$( \
    echo "$( \
        find /dev -maxdepth 1 -regextype posix-extended -iregex '.+/nvidia([0-9]|ctl)' \
            | grep --color=never '.' \
          || echo '/dev/dri'\
      )" \
      | sed -E "s/^/--device /" \
  )

# get the xdg runtime dir
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# create the container
docker create \
  --name firefox \
  --security-opt apparmor:unconfined \
  --net host \
  --device /dev/input \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/Downloads:/downloads \
  -v $HOME/.config/firefox:/data \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /dev/shm:/dev/shm \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse:ro \
  -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
  -v /var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro \
  -v /run/dbus:/run/dbus:ro \
  -v /run/udev/data:/run/udev/data:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/firefox-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /data` | Firefox data |
| `-v /downloads` | Firefox download directory |
