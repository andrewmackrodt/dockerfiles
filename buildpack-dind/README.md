# [andrewmackrodt/docker-buildpack-dind](https://github.com/andrewmackrodt/dockerfiles/tree/master/buildpack-dind)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fbuildpack-dind)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/buildpack-dind.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/buildpack-dind/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/buildpack-dind)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/buildpack-dind)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/buildpack-dind/
[pulls]: https://hub.docker.com/r/andrewmackrodt/buildpack-dind
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/buildpack-dind/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/buildpack-dind
[version]: https://hub.docker.com/r/andrewmackrodt/buildpack-dind/tags

[Ubuntu](https://www.ubuntu.com/) 20.04 (Focal) base image with build dependencies
and docker client. Includes packages from the [official](https://github.com/docker-library/buildpack-deps/blob/65d69325ad741cea6dee20781c1faaab2e003d87/ubuntu/focal/Dockerfile)
ubuntu buildpack-deps image.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Usage

### Dockerfile

```
FROM andrewmackrodt/buildpack-dind

...
```
