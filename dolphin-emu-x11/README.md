# [andrewmackrodt/docker-dolphin-emu-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/dolphin-emu-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fdolphin-emu-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/dolphin-emu-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/dolphin-emu-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/dolphin-emu-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/dolphin-emu-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/dolphin-emu-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/dolphin-emu-x11
[layers]: https://microbadger.com/images/andrewmackrodt/dolphin-emu-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/dolphin-emu-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/dolphin-emu-x11/tags

[Dolphin](https://dolphin-emu.org/) is an emulator for two recent Nintendo video
game consoles: the GameCube and the Wii. It allows PC gamers to enjoy games for
these two consoles in full HD (1080p) with several enhancements: compatibility
with all PC controllers, turbo speed, networked multiplayer, and even more! 

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
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
        find /dev -maxdepth 1 -regextype posix-extended -iregex '.+/nvidia([0-9]|ctl|-modeset)' \
            | grep --color=never '.' \
          || echo '/dev/dri'\
      )" \
      | sed -E "s/^/--device /" \
  )

# get the xdg runtime dir
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# create the container
docker create \
  --name dolphin-emu \
  --security-opt apparmor:unconfined \
  --net host \
  --shm-size 128M \
  --device /dev/input \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/.dolphin-emu/Config:/config \
  -v $HOME/.dolphin-emu:/data \
  -v $HOME/Games/GameCube:/gc:ro \
  -v $HOME/Games/Wii:/wii:ro \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v $XDG_RUNTIME_DIR:/run/user/$(id -u)/pulse:ro \
  -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
  -v /var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro \
  -v /run/dbus:/run/dbus:ro \
  -v /run/udev/data:/run/udev/data:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/dolphin-emu-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-v /config` | Dolphin config directory (.ini files) |
| `-v /data` | Dolphin data directory (game saves etc) |
| `-v /gc` | GameCube ISOs directory |
| `-v /wii` | Wii ISOs directory |
