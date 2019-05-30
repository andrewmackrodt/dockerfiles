# [andrewmackrodt/docker-nodejs](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs)

[Node.js](https://nodejs.org/) is a JavaScript runtime built on Chrome's V8 JavaScript engine.

<small>Links: [Docker Hub][repository] | [Dockerfile][dockerfile]</small>

[repository]: https://cloud.docker.com/repository/docker/andrewmackrodt/nodejs
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/nodejs/Dockerfile

## Versions

The `Current` major Node.js (v12) is tagged as `latest`. `LTS` and `Maintenance` images are also provided:

- `andrewmackrodt/nodejs:8` Maintenance (end-of-life: 2019-12-31)
- `andrewmackrodt/nodejs:10` LTS (maintenance start: 2020-04-01)
- `andrewmackrodt/nodejs:12` Current (LTS start: 2019-10-22)

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
