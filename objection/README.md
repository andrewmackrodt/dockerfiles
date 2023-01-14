# [andrewmackrodt/docker-objection](https://github.com/andrewmackrodt/dockerfiles/tree/master/objection)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fobjection)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/objection.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/objection/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/objection)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/objection)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/objection/
[pulls]: https://hub.docker.com/r/andrewmackrodt/objection
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/objection/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/objection
[version]: https://hub.docker.com/r/andrewmackrodt/objection/tags

[objection](https://github.com/sensepost/objection) is a runtime mobile
exploration toolkit, powered by Frida, built to help you assess the security
posture of your mobile applications, without needing a jailbreak.

## Usage
<span data-message="dockerhub formatting fix"></span>
### docker

```
# run objection patchapk
docker run --rm -it -v "$PWD:/data" -w /data andrewmackrodt/objection \
  -- \
  patchapk -s MyApp.apk -a arm64-v8a
```

## Parameters

| Parameter            | Function                              |
|----------------------|---------------------------------------|
| `-e PUID=1000`       | The user id, recommended: `$(id -u)`  |
| `-e PGID=1000`       | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
