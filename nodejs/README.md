# [andrewmackrodt/docker-nodejs](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fnodejs)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/nodejs.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/nodejs.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/nodejs/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/nodejs.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/nodejs/
[pulls]: https://hub.docker.com/r/andrewmackrodt/nodejs
[layers]: https://microbadger.com/images/andrewmackrodt/nodejs
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/nodejs/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/nodejs/tags

[Node.js](https://nodejs.org/) is a JavaScript runtime built on Chrome's V8 JavaScript engine.

## Versions

The `Current` major Node.js (v15) is tagged as `latest`. `LTS` and `Maintenance` images are also provided:

- `andrewmackrodt/nodejs:12` Maintenance (end-of-life: 2022-04-30)
- `andrewmackrodt/nodejs:14` LTS (maintenance start: 2023-04-30)
- `andrewmackrodt/nodejs:15` Current (LTS start: 2021-06-01)

All images are bundled with [npm](https://www.npmjs.com/) and [yarn](https://yarnpkg.com/).

**Update Schedule**

Images are built nightly and images will be updated as new `major.minor.patch-release`
packages of Node.js are released. It's possible to pull a specific tag, e.g.
`docker pull andrewmackrodt/nodejs:10.16.0-r1`, see [Docker Hub][hub] for a list of
supported tags.

[hub]: https://hub.docker.com/r/andrewmackrodt/nodejs/tags

**Removal Policy**

Old tags are subject to removal periodically without notice.

## Usage

### docker

```
# start interactive mode
docker run --rm -it andrewmackrodt/nodejs

# print version
docker run --rm andrewmackrodt/nodejs --version

# run npm install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/nodejs npm install

# run yarn install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/nodejs yarn install
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
