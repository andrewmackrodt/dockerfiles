# [andrewmackrodt/docker-firefox-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/firefox-x11)

[Firefox](https://www.mozilla.org/en-GB/firefox/new/) is a free and open-source
web browser developed by the Mozilla Foundation and its subsidiary, Mozilla
Corporation.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia)
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

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


# create the data volume
docker volume create --name firefox

# create the container
docker create \
  --name firefox \
  --net host \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/Downloads:/downloads \
  -v firefox:/data \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e XDG_RUNTIME_DIR=/run/user/$(id -u) \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /dev/shm:/dev/shm \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
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
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /data` | Firefox data |
| `-v /downloads` | Firefox download directory |
