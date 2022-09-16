# [andrewmackrodt/docker-chromium-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/chromium-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fchromium-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/chromium-x11.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/chromium-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/chromium-x11)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/chromium-x11)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/chromium-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/chromium-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/chromium-x11/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/chromium-x11
[version]: https://hub.docker.com/r/andrewmackrodt/chromium-x11/tags

[Chromium](https://www.chromium.org/Home) is an open-source browser project that aims
to build a safer, faster, and more stable way for all Internet users to
experience the web.

## Features

* OpenGL acceleration (Mesa DRI/GLX and nvidia †)
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

**† nvidia driver note**

libnvidia-gl-515 is provided in the image, being the current supported version
in the latest Ubuntu LTS release. The host driver version will be checked every
time the container is started and if there is a version mismatch, an attempt
to install the correct driver in the container will be made unless:

1. Any of the following directories are present: `/usr/local/nvidia/lib`,
   `/usr/local/nvidia/lib64` or `/nvidia`. It is assumed that the correct
   libraries are mounted from the host. Directories will be added to
   `/etc/ld.so.conf.d/nvidia.conf`.
2. The environment variable `NVIDIA_SKIP_DOWNLOAD=1` has been set.
3. The installed driver matches the host `/proc/driver/nvidia/version`.

The first option is the preferred way to add nvidia drivers to the container.
See [here][gist] for an example on generating the required files on the host.
It may also be possible to achieve this using [nvidia-docker][nvidia-docker].

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8
[nvidia-docker]: https://github.com/NVIDIA/nvidia-docker

## Usage
<span data-message="dockerhub formatting fix"></span>
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
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-e LANG=en_US.UTF-8` | The language to use, e.g. "de_DE" |
| `-v /data` | Chromium data |
| `-v /downloads` | Chromium download directory |
