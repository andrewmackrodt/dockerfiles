# [andrewmackrodt/docker-ubuntu-x11](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu-x11)

Ubuntu 18.04 (Bionic) base image for X11 applications.

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
