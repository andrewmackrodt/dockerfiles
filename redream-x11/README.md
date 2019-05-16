# [andrewmackrodt/docker-redream-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/redream-x11)

[Redream](https://redream.io/) is a work-in-progress Dreamcast emulator,
enabling you to play your favorite Dreamcast games in high-definition.

## Features

* NVidia GPU acceleration
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

## Usage

### docker

```
docker create \
  --name redream \
  --privileged \
  --device /dev/snd \
  -v $HOME/Games/Dreamcast:/games:ro \
  -v $HOME/.redream/saves:/saves \
  -v $HOME/.redream/config:/config \
  -v $HOME/.redream/bios:/bios \
  -v $HOME/.redream/cache:/cache \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/redream-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /games` | Redream games directory |
| `-v /saves` | Redream save files (vmu*.bin) |
| `-v /config` | Redream config files (redream.cfg, redream.key) |
| `-v /bios` | Redream ROM files (boot.bin, flash.bin) |
| `-v /cache` | Redream cache directory |
