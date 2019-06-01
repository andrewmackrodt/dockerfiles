# [andrewmackrodt/docker-chromium-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/chromium-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?style=flat-square&job=dockerfiles%2Fchromium-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/chromium-x11.svg?style=flat-square)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/chromium-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/chromium-x11/Dockerfile.svg?style=flat-square&label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/chromium-x11.svg?style=flat-square)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/chromium-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/chromium-x11
[layers]: https://microbadger.com/images/andrewmackrodt/chromium-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/chromium-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/chromium-x11/tags

[Chromium](https://www.chromium.org/Home) is an open-source browser project that aims
to build a safer, faster, and more stable way for all Internet users to
experience the web.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Audio via ALSA (fallback)
* Controller support (tested with wireless DS4 over Bluetooth)

† libnvidia-gl-390 is installed, see [here][gist] if you have a different
proprietary NVidia driver installed on how to mount the correct drivers to
the container without requiring an image rebuild.

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8

## Usage

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
  --name chromium \
  --cap-add SYS_ADMIN \
  --security-opt apparmor:unconfined \
  --net host \
  --device /dev/input \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/Downloads:/downloads \
  -v $HOME/.config/chromium:/data \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e LANG=${LANG:-en_US.UTF-8} \
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
  andrewmackrodt/chromium-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-e LANG=en_US.UTF-8` | The language to use, e.g. "de_DE" |
| `-e ALSA_PCM=<device>` | The ALSA device, e.g. "dmix:CARD=NVidia,DEV=8", see `aplay -L` |
| `-v /data` | Chromium data |
| `-v /downloads` | Chromium download directory |

_Setting `ALSA_PCM` should only be used if it's not possible to use pulseaudio.
ALSA requires exclusive access to the audio device whereas pulseaudio can share
the device between the host and other containers and is probably what you want._
