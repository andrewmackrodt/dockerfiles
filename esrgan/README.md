# [andrewmackrodt/docker-esrgan](https://github.com/andrewmackrodt/dockerfiles/tree/master/esrgan)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fesrgan)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/esrgan.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/esrgan/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/esrgan)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/esrgan)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/esrgan/
[pulls]: https://hub.docker.com/r/andrewmackrodt/esrgan
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/esrgan/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/esrgan
[version]: https://hub.docker.com/r/andrewmackrodt/esrgan/tags

[ESRGAN](https://github.com/xinntao/ESRGAN) (Enhanced SRGAN) is a seminal work
that is capable of generating realistic textures during single image
super-resolution.

## Usage

See https://github.com/xinntao/ESRGAN/blob/master/README.md, all dependencies to
generate the sample images in `LR/` (including pretrained models) are included.

```
docker run --rm -it andrewmackrodt/esrgan bash
cd ESRGAN
sed -i "s/torch.device('cuda')/torch.device('cpu')/" test.py
python test.py
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
