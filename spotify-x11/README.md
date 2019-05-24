# [andrewmackrodt/docker-spotify-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/spotify-x11)

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
  -e XDG_RUNTIME_DIR=/run/user/$(id -u) \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
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
