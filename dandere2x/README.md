# [andrewmackrodt/docker-dandere2x](https://github.com/andrewmackrodt/dockerfiles/tree/master/dandere2x)

**dandere2x doesn't work on linux yet, this will not work**

[Dandere2x](https://github.com/aka-katto/dandere2x) makes upscaling videos with
waifu2x much faster by applying compression techniques. In other words,
Dandere2x uses techniques used from video streaming (such as Youtube or Netflix)
to decrease the time needed to upscale a video using Waifu2x.

## Usage

### docker

```
# convert first 10 seconds of video.mkv in the current directory
docker run --rm -it \
  --privileged \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/workspace \
  andrewmackrodt/dandere2x npm install
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e NVIDIA_SKIP_DOWNLOAD=0` | Set to `1` to skip nvidia driver update |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
