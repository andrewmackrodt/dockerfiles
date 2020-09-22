# [andrewmackrodt/docker-nvidia-snatcher](https://github.com/andrewmackrodt/dockerfiles/tree/master/nvidia-snatcher)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fnvidia-snatcher)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/nvidia-snatcher.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/nvidia-snatcher.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/nvidia-snatcher/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/nvidia-snatcher.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/nvidia-snatcher/
[pulls]: https://hub.docker.com/r/andrewmackrodt/nvidia-snatcher
[layers]: https://microbadger.com/images/andrewmackrodt/nvidia-snatcher
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/nvidia-snatcher/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/nvidia-snatcher/tags

[nvidia-snatcher](https://github.com/jef/nvidia-snatcher) image.

## Usage

### docker

```
# run the snatcher using uk stores without containerized chromium window 
docker run --rm -it \
  --network=host \
  -e "COUNTRY=great_britain" \
  -e "DISPLAY=unix$DISPLAY" \
  -e "LANG=${LANG:-en_US.UTF-8}" \
  -e "PGID=$(id -g)" \
  -e "PUID=$(id -u)" \
  -e "STORES=nvidia,overclockers,scan,ebuyer,novatech,box" \
  -e "TRUSTED=true" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  andrewmackrodt/nvidia-snatcher

# run the snatcher without containerized chromium window 
docker run --rm -it \
  --network=host \
  -e "DISPLAY=unix$DISPLAY" \
  -e "LANG=${LANG:-en_US.UTF-8}" \
  -e "PGID=$(id -g)" \
  -e "PUID=$(id -u)" \
  -e "TRUSTED=true" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  andrewmackrodt/nvidia-snatcher

# run the snatcher with containerized chromium window forwarded using X11 
docker run --rm -it \
  --cap-add=SYS_ADMIN \
  --network=host \
  -e "DISPLAY=unix$DISPLAY" \
  -e "LANG=${LANG:-en_US.UTF-8}" \
  -e "PGID=$(id -g)" \
  -e "PUID=$(id -u)" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  andrewmackrodt/nvidia-snatcher
```

## Parameters

See https://github.com/jef/nvidia-snatcher#customization.

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
