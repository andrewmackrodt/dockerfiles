# [andrewmackrodt/docker-redream-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/redream-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fredream-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/redream-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/redream-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/redream-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/redream-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/redream-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/redream-x11
[layers]: https://microbadger.com/images/andrewmackrodt/redream-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/redream-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/redream-x11/tags

[Redream](https://redream.io/) is a work-in-progress Dreamcast emulator,
enabling you to play your favorite Dreamcast games in high-definition.

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

### docker

```
# detect gpu devices to pass through
GPU_DEVICES=$( \
    echo "$( \
        find /dev -maxdepth 1 -regextype posix-extended -iregex '.+/nvidia([0-9]|ctl|-modeset)' \
            | grep --color=never '.' \
          || echo '/dev/dri'\
      )" \
      | sed -E "s/^/--device /" \
  )

# create the container
docker create \
  --name redream \
  --net host \
  --device /dev/input \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/Games/Dreamcast:/games:ro \
  -v $HOME/.redream/vmu:/vmu \
  -v $HOME/.redream/saves:/saves \
  -v $HOME/.redream/config:/config \
  -v $HOME/.redream/bios:/bios \
  -v $HOME/.redream/cache:/cache \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e XDG_RUNTIME_DIR=/run/user/$(id -u) \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v /run/udev/data:/run/udev/data:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/redream-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /games` | Redream games directory |
| `-v /vmu` | Redream save files (vmu*.bin) |
| `-v /saves` | Redream savestates |
| `-v /config` | Redream config files (redream.cfg, redream.key) |
| `-v /bios` | Redream ROM files (boot.bin, flash.bin) |
| `-v /cache` | Redream cache directory |
