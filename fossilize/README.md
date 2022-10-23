# [andrewmackrodt/docker-fossilize](https://github.com/andrewmackrodt/dockerfiles/tree/master/fossilize)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Ffossilize)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/fossilize.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/fossilize/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/fossilize)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/fossilize)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/fossilize/
[pulls]: https://hub.docker.com/r/andrewmackrodt/fossilize
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/fossilize/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/fossilize
[version]: https://hub.docker.com/r/andrewmackrodt/fossilize/tags

[Fossilize](https://github.com/ValveSoftware/Fossilize) is a library and Vulkan
layer for serializing various persistent Vulkan objects which typically end up
in hashmaps.

## Usage
<span data-message="dockerhub formatting fix"></span>
### docker

```
docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-bench [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-convert-db [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-disasm [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-list [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-merge-db [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-opt [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-prune [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-rehash [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-replay [options]

docker run --rm -e "PUID=$(id -u)"  -e "PGID=$(id -g)" -v "$PWD:$PWD" -w "$PWD" \
  andrewmackrodt/fossilize fossilize-synth [options]

```

## Parameters

| Parameter            | Function                              |
|----------------------|---------------------------------------|
| `-e PUID=1000`       | The user id, recommended: `$(id -u)`  |
| `-e PGID=1000`       | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
