# [andrewmackrodt/docker-buildpack-deps](https://github.com/andrewmackrodt/dockerfiles/tree/master/buildpack-deps)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fbuildpack-deps)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/buildpack-deps.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/buildpack-deps.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/buildpack-deps/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/buildpack-deps.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/buildpack-deps/
[pulls]: https://hub.docker.com/r/andrewmackrodt/buildpack-deps
[layers]: https://microbadger.com/images/andrewmackrodt/buildpack-deps
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/buildpack-deps/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/buildpack-deps/tags

[Ubuntu](https://www.ubuntu.com/) 18.04 (Bionic) base image with build dependencies.
Includes packages from the [official](https://github.com/docker-library/buildpack-deps/blob/ff09b5c5288f4643056bd7938268d749e9f8a2db/bionic/Dockerfile)
ubuntu buildpack-deps image.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Usage

### Dockerfile

```
FROM andrewmackrodt/buildpack-deps

...
```
