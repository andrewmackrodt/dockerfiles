# [andrewmackrodt/docker-ubuntu-x11-i386](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu-x11-i386)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fubuntu-x11-i386)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/ubuntu-x11-i386.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/ubuntu-x11-i386.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/ubuntu-x11-i386/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/ubuntu-x11-i386.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/ubuntu-x11-i386/
[pulls]: https://hub.docker.com/r/andrewmackrodt/ubuntu-x11-i386
[layers]: https://microbadger.com/images/andrewmackrodt/ubuntu-x11-i386
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/ubuntu-x11-i386/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/ubuntu-x11-i386/tags

[Ubuntu](https://www.ubuntu.com/) 20.04 (Focal) base image for i386 X11 applications.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Examples
- [andrewmackrodt/pcsx2-x11](https://hub.docker.com/r/andrewmackrodt/pcsx2-x11)

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Input devices via rtkit (e.g. bluetooth controllers)

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

## Usage

### Dockerfile

```
FROM andrewmackrodt/ubuntu-x11-i386

...
```
