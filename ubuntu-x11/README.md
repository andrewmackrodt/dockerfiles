# [andrewmackrodt/docker-ubuntu-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu-x11)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fubuntu-x11)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/ubuntu-x11.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/ubuntu-x11.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/ubuntu-x11/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/ubuntu-x11.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/ubuntu-x11/
[pulls]: https://hub.docker.com/r/andrewmackrodt/ubuntu-x11
[layers]: https://microbadger.com/images/andrewmackrodt/ubuntu-x11
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/ubuntu-x11/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/ubuntu-x11/tags

[Ubuntu](https://www.ubuntu.com/) 18.04 (Bionic) base image for X11 applications.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Examples
- [andrewmackrodt/chromium-x11](https://hub.docker.com/r/andrewmackrodt/chromium-x11)
- [andrewmackrodt/firefox-x11](https://hub.docker.com/r/andrewmackrodt/firefox-x11)

## Features

* OpenGL acceleration (Mesa DRI/GLX and NVidia †)
* Audio via PulseAudio
* Input devices via rtkit (e.g. bluetooth controllers)

† libnvidia-gl-390 is installed, see [here][gist] if you have a different
proprietary NVidia driver installed on how to mount the correct drivers to
the container without requiring an image rebuild.

[gist]: https://gist.github.com/andrewmackrodt/e5f9eaf63c9296db73901796bc46a3f8

## Usage

### Dockerfile

```
FROM andrewmackrodt/ubuntu-x11

...
```
