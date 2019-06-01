# [andrewmackrodt/docker-nodejs-chromium](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs-chromium)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fnodejs-chromium)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/nodejs-chromium.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/nodejs-chromium.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/nodejs-chromium/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/nodejs-chromium.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/nodejs-chromium/
[pulls]: https://hub.docker.com/r/andrewmackrodt/nodejs-chromium
[layers]: https://microbadger.com/images/andrewmackrodt/nodejs-chromium
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/nodejs-chromium/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/nodejs-chromium/tags

[Node.js](https://nodejs.org/) 12.x image with [npm](https://www.npmjs.com/),
[yarn](https://yarnpkg.com/) and [chromium](https://www.chromium.org/) for
applications requiring a headless browser, e.g. to for SSR.

See [andrewmackrodt/docker-nodejs](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs)
for more details.

## Usage

**Important**

This image exports the environment variable `PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true`.

### docker

```
# start interactive mode
docker run --rm -it andrewmackrodt/nodejs-chromium

# print version
docker run --rm andrewmackrodt/nodejs-chromium --version

# run npm install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/nodejs-chromium npm install

# run yarn install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/nodejs-chromium yarn install
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true` | Set to false if using puppeteer and you don't want to use the bundled chromium browser |
