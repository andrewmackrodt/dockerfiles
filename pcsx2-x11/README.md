# [andrewmackrodt/docker-pcsx2-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/pcsx2-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fpcsx2-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/pcsx2-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/pcsx2-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/pcsx2-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/pcsx2-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/pcsx2-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/pcsx2-x11
[layers]: https://microbadger.com/images/andrewmackrodt/pcsx2-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/pcsx2-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/pcsx2-x11/tags

[PCSX2](https://pcsx2.net/) is a free and open-source PlayStation 2 (PS2)
emulator. Its purpose is to emulate the PS2's hardware, using a combination
of MIPS CPU Interpreters, Recompilers and a Virtual Machine which manages
hardware states and PS2 system memory. This allows you to play PS2 games on
your PC, with many additional features and benefits.

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Controller support (tested with wireless DS4 over Bluetooth)

**† NVidia driver note**

libnvidia-gl-455 is provided in the image, being the current supported version
in the latest Ubuntu LTS release. The host driver version will be checked every
time the container is started and if there is a version mismatch, an attempt
to install the correct driver in the container will be made unless:

1. Any of the following directories are present: `/usr/local/nvidia/lib`,
   `/usr/local/nvidia/lib64` or `/nvidia`. It is assumed that the correct
   libraries are mounted from the host. Directories will be added to
   `/etc/ld.so.conf.d/nvidia.conf`.
2. The environment variable `NVIDIA_SKIP_DOWNLOAD=1` has been set.
3. The installed driver matches the host `/proc/driver/nvidia/version`.

The first option is the preferred way to add NVidia drivers to the container.
See [here][gist] for an example on generating the required files on the host.
It may also be possible to achieve this using [nvidia-docker][nvidia-docker].

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8
[nvidia-docker]: https://github.com/NVIDIA/nvidia-docker

## Requirements

PCSX2 requires an original Playstation 2 BIOS, this cannot be included in the
image for copyright reasons. If you have a homebrew enabled Playstation 2,
you can dump the BIOS using the [tools][pcsx2-tools] from the PCSX2 website.

Alternatively, if you have previously created a BIOS backup, you may set the
environment variable `BIOS_ZIP` to the backup url and it will be downloaded
automatically during container start. This must be a zip file which contains
the BIOS .bin file(s) in the root of the archive. Additionally, a SHA-256
hash may be specified via `BIOS_CHECKSUM` to ensure the correct file is being
processed.

BIOS files should be placed in `/bios`, e.g.
`docker run -v ~/.pcsx2/bios:/bios ... andrewmackrodt/pcsx2-x11`. 

[pcsx2-tools]: https://pcsx2.net/download/releases/tools.html

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
  --name pcsx2 \
  --cap-add NET_ADMIN \
  --net host \
  --device /dev/input \
  --device /dev/snd \
  $GPU_DEVICES \
  -v $HOME/Games/PS2:/games:ro \
  -v $HOME/.pcsx2/data:/data \
  -v $HOME/.pcsx2/bios:/bios \
  -v $HOME/.pcsx2/plugins:/plugins \
  -e BIOS_ZIP=${BIOS_ZIP:-} \
  -e BIOS_CHECKSUM=${BIOS_CHECKSUM:-} \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e DISPLAY=unix$DISPLAY \
  -e LANG=${LANG:-en_US.UTF-8} \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.config/pulse:/home/ubuntu/.config/pulse:ro \
  -v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse:ro \
  -v /run/udev/data:/run/udev/data:ro \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/pcsx2-x11
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e TZ=UTC` | The timezone, e.g. "Europe/London" |
| `-e LANG=en_US.UTF-8` | The language to use, e.g. "de_DE" |
| `-e BIOS_ZIP=` | URL to the zip file containing BIOS file(s) |
| `-e BIOS_CHECKSUM=` | SHA-256 used to verify the zip file |
| `-v /games` | PCSX2 games directory |
| `-v /data` | PCSX2 data directory |
| `-v /bios` | PCSX2 bios directory |
| `-v /plugins` | PCSX2 plugins directory |
