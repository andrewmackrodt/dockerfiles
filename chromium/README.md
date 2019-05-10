# [andrewmackrodt/docker-chromium](https://github.com/andrewmackrodt/dockerfiles/tree/master/chromium)

[Chromium](https://www.chromium.org/Home) is an open-source browser project that aims
to build a safer, faster, and more stable way for all Internet users to
experience the web.

## Image Features

* NVidia GPU acceleration
* Audio via pulseaudio (shared)
* Audio via alsa (exclusive)

## Usage

### docker

```
docker volume create --name chromium

docker create \
  --name chromium \
  --privileged \
  --net host \
  --device /dev/snd \
  -v $HOME/Downloads:/downloads \
  -v chromium:/data \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e XDG_RUNTIME_DIR=/run/user/$(id -u) \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /dev/shm:/dev/shm \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v /run/dbus:/run/dbus:ro \
  -v /var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/chromium
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-e ALSA_PCM=<device>` | The ALSA device, e.g. "dmix:CARD=NVidia,DEV=8", see `aplay -L` |
| `-v /data` | Chromium data |
| `-v /downloads` | Chromium download directory |

_Setting `ALSA_PCM` should only be used if it's not possible to use pulseaudio.
ALSA requires exclusive access to the audio device whereas pulseaudio can share
the device between the host and other containers and is probably what you want._
