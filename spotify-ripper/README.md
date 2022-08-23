# [andrewmackrodt/docker-spotify-ripper](https://github.com/andrewmackrodt/dockerfiles/tree/master/spotify-ripper)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fspotify-ripper)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/spotify-ripper.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/spotify-ripper/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/spotify-ripper)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/spotify-ripper)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/spotify-ripper/
[pulls]: https://hub.docker.com/r/andrewmackrodt/spotify-ripper
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/spotify-ripper/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/spotify-ripper
[version]: https://hub.docker.com/r/andrewmackrodt/spotify-ripper/tags

[spotify-ripper](https://github.com/hbashton/spotify-ripper) is a small ripper
script for Spotify that rips Spotify URIs to audio files and includes ID3 tags
and cover art. By default spotify-ripper will encode to MP3 files, but includes
the ability to rip to WAV, FLAC, Ogg Vorbis, Opus, AAC, and MP4/M4A.

**Note that stream ripping violates the libspotify's ToS**

## Usage

See https://github.com/hbashton/spotify-ripper#command-line.

```
docker run --rm -it \
    -v "$HOME/Music:/music" \
    andrewmackrodt/spotify-ripper \
    -- \
    --user email@provider.tld \
    --password 12345678 \
    spotify:track:52xaypL0Kjzk0ngwv3oBPR
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-v /music` | Downloads directory |
