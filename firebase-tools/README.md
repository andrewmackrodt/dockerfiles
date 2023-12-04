# [andrewmackrodt/docker-firebase-tools](https://github.com/andrewmackrodt/dockerfiles/tree/master/firebase-tools)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Ffirebase-tools)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/firebase-tools.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/firebase-tools/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/firebase-tools)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/firebase-tools)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/firebase-tools/
[pulls]: https://hub.docker.com/r/andrewmackrodt/firebase-tools
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/firebase-tools/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/firebase-tools
[version]: https://hub.docker.com/r/andrewmackrodt/firebase-tools/tags

[Node.js](https://nodejs.org/) 20.x image with [npm](https://www.npmjs.com/),
[firebase-tools](https://firebase.google.com/docs/cli/).

See [andrewmackrodt/docker-nodejs](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs)
for more details.

## Usage
<span data-message="dockerhub formatting fix"></span>
### docker

```
# print version
docker run --rm andrewmackrodt/firebase-tools --version

# login to firebase interactively local
# linux users can use "--network=host" instead of "-p"
docker run --rm -it \
    -p 9005:9005 \
    -v "$HOME/.fierbase:/config" \
    andrewmackrodt/firebase-tools \
    -- \
    login

# login to firebase interactively remote
docker run --rm -it \
    -v "$HOME/.fierbase:/config" \
    andrewmackrodt/firebase-tools \
    -- \
    login --no-localhost

# initialize a new project
docker run --rm \
    -v "$HOME/.fierbase:/config" \
    -v "$PWD:/app" \
    -w /app \
    andrewmackrodt/firebase-tools \
    -- \
    init
```

## Parameters

| Parameter            | Function                              |
|----------------------|---------------------------------------|
| `-e PUID=1000`       | The user id, recommended: `$(id -u)`  |
| `-e PGID=1000`       | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-v /config`         | Firebase config directory             |
