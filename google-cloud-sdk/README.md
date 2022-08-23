# [andrewmackrodt/docker-google-cloud-sdk](https://github.com/andrewmackrodt/dockerfiles/tree/master/google-cloud-sdk)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fgoogle-cloud-sdk)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/google-cloud-sdk.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/google-cloud-sdk/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/google-cloud-sdk)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/google-cloud-sdk)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/google-cloud-sdk/
[pulls]: https://hub.docker.com/r/andrewmackrodt/google-cloud-sdk
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/google-cloud-sdk/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/google-cloud-sdk
[version]: https://hub.docker.com/r/andrewmackrodt/google-cloud-sdk/tags

[google-cloud-sdk](https://cloud.google.com/sdk/) based on Ubuntu 20.04.

See [andrewmackrodt/ubuntu](https://github.com/andrewmackrodt/dockerfiles/tree/master/ubuntu)
for more details.

## Usage

### docker

```
# print version
docker run --rm andrewmackrodt/google-cloud-sdk --version

# login to google cloud interactively
docker run --rm -it \
    -v "$HOME/.config/gcloud:/config" \
    andrewmackrodt/google-cloud-sdk \
    -- \
    auth login

# list managed cloud run revisions in europe-west1
docker run --rm \
    -v "$HOME/.config/gcloud:/config" \
    andrewmackrodt/google-cloud-sdk \
    -- \
    beta run revisions list --region europe-west1 --platform managed
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-v /config` | Google Cloud SDK config directory |
