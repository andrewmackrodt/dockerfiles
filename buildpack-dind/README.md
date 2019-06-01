# [andrewmackrodt/docker-buildpack-dind](https://github.com/andrewmackrodt/dockerfiles/tree/master/buildpack-dind)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fbuildpack-dind)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/buildpack-dind.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/buildpack-dind.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/buildpack-dind/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/buildpack-dind.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/buildpack-dind/
[pulls]: https://hub.docker.com/r/andrewmackrodt/buildpack-dind
[layers]: https://microbadger.com/images/andrewmackrodt/buildpack-dind
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/buildpack-dind/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/buildpack-dind/tags

[Ubuntu](https://www.ubuntu.com/) 18.04 (Bionic) base image with build dependencies
and docker client. Includes packages from the [official](https://github.com/docker-library/buildpack-dind/blob/ff09b5c5288f4643056bd7938268d749e9f8a2db/bionic/Dockerfile)
ubuntu buildpack-deps image.

See [andrewmackrodt/docker-ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Usage

### Dockerfile

```
FROM andrewmackrodt/buildpack-dind

...
```
