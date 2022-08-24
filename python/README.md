# [andrewmackrodt/docker-python](https://github.com/andrewmackrodt/dockerfiles/tree/master/python)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fpython)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/python.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/python/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/python)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/python)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/python/
[pulls]: https://hub.docker.com/r/andrewmackrodt/python
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/python/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/python
[version]: https://hub.docker.com/r/andrewmackrodt/python/tags

[Python](https://www.python.org/) is an interpreted, object-oriented, high-level
programming language with dynamic semantics. Its high-level built in data
structures, combined with dynamic typing and dynamic binding, make it very
attractive for Rapid Application Development, as well as for use as a scripting
or glue language to connect existing components together.

## Versions

Python `3.9` is tagged as `latest`. Images for versions `2.7` and`3.8` are also provided:

- <strike>`andrewmackrodt/python:2.7` security (end-of-life: 2020-01-01)</strike>
- `andrewmackrodt/python:3.8` bugfix (end-of-life: 2024-10-14)
- `andrewmackrodt/python:3.9` bugfix (end-of-life: 2025-10-05)

**Update Schedule**

Images are built nightly and images will be updated as new `major.minor.patch-release`
packages of PYTHON are released. It's possible to pull a specific tag, e.g.
`docker pull andrewmackrodt/python:3.9.0-r5`, see [Docker Hub][hub] for a list of
supported tags.

[hub]: https://hub.docker.com/r/andrewmackrodt/python/tags

**Removal Policy**

Old tags are subject to removal periodically without notice.

## Usage
<span data-message="dockerhub formatting fix"></span>
### docker

```
# start interactive mode
docker run --rm -it andrewmackrodt/python

# print version
docker run --rm andrewmackrodt/python --version
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
