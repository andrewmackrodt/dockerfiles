# [andrewmackrodt/docker-buildpack-deps](https://github.com/andrewmackrodt/dockerfiles/tree/master/buildpack-deps)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fbuildpack-deps)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/buildpack-deps.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/buildpack-deps/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/buildpack-deps)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/buildpack-deps)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/buildpack-deps/
[pulls]: https://hub.docker.com/r/andrewmackrodt/buildpack-deps
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/buildpack-deps/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/buildpack-deps
[version]: https://hub.docker.com/r/andrewmackrodt/buildpack-deps/tags

[Ubuntu](https://www.ubuntu.com/) 20.04 (Focal) base image with build dependencies.
Includes packages from the [official](https://github.com/docker-library/buildpack-deps/blob/65d69325ad741cea6dee20781c1faaab2e003d87/ubuntu/focal/Dockerfile)
ubuntu buildpack-deps image.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Usage

### Dockerfile

```
FROM andrewmackrodt/buildpack-deps

...
```
