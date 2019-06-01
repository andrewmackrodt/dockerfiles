# [andrewmackrodt/docker-spotify-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/spotify-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?style=flat-square&job=dockerfiles%2Fspotify-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/spotify-x11.svg?style=flat-square)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/spotify-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/spotify-x11/Dockerfile.svg?style=flat-square&label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/spotify-x11.svg?style=flat-square)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/spotify-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/spotify-x11
[layers]: https://microbadger.com/images/andrewmackrodt/spotify-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/spotify-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/spotify-x11/tags

[Spotify](https://www.spotify.com/)  is a digital music service that gives you
access to millions of songs.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio

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

# create the container
docker create \
  --name spotify \
  --net host \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/.config/spotify:/config \
  -v $HOME/.cache/spotify:/cache \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
  -v /var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro \
  -v /run/dbus:/run/dbus:ro \
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
