# [andrewmackrodt/dockerfiles](https://github.com/andrewmackrodt/dockerfiles)

Dockerfiles based on Ubuntu 22.04 (Jammy).

## Features

* Default non-root user account `ubuntu` with optional passwordless sudo
* Configurable UID via environment variable
* Configurable GID via environment variable
* Configurable timezone via environment variable or /etc/localtime mount
* Automatic init using [tini][tini] or [s6-overlay][s6] to reap zombies
* Automatic step down from root to ubuntu via [gosu][gosu]

[tini]: https://github.com/krallin/tini
[s6]: https://github.com/just-containers/s6-overlay
[gosu]: https://github.com/tianon/gosu

## Introduction

All images (unless explicitly mentioned in their documentation) run as the user
`ubuntu` with the working directory `/home/ubuntu`. Starting containers in this
manner allows commands such as `docker exec ...` to run with the correct PID/GID
(configured at container start) without having to remember to prefix
`--user $(id -u):$(id -g)` before all commands.

### Entrypoint

Containers use the entrypoint `/usr/local/bin/docker-entrypoint.sh` which
elevates itself as `root`, configures the UID, GID and timezone and starts the
init system (`tini` or `s6-overlay` depending on the container). Finally, `gosu` is
used to step down to the `ubuntu` user before executing the container specific
entrypoint (defined by environment variable `ENTRYPOINT0`) or user command.

### PID 1

Under normal operation PID 1 will be the `sudo` command which invokes the init
system. In my testing, signal processing propagates correctly to the `tini` or
`s6-overlay` processes which are the only other top-level processes. However, it
is also possible to start the container with the option `--user root` which will
make the init process PID 1. Note that `docker exec` will run as `root` if this
option is specified.

```
$ docker run --rm andrewmackrodt/ubuntu -c "id -a; date; ps faux"

uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),4(adm)
Wed May 15 13:55:25 UTC 2019
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  47704  3496 ?        Ss   13:55   0:00 sudo -E tini -s -g /usr/local/bin/docker-entrypoint.sh -- -c id -a; date; ps faux
root         8  0.0  0.0   4520   752 ?        S    13:55   0:00 tini -s -g /usr/local/bin/docker-entrypoint.sh -- -c id -a; date; ps faux
ubuntu       9  0.0  0.0  18376  2816 ?        S    13:55   0:00  \_ /bin/bash -c id -a; date; ps faux
ubuntu      61  0.0  0.0  34400  2792 ?        R    13:55   0:00      \_ ps faux

$ docker run --rm --user root andrewmackrodt/ubuntu -c "id -a; date; ps faux"

uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),4(adm)
Wed May 15 13:56:21 UTC 2019
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ubuntu       1  3.0  0.0   4520   724 ?        Ss   13:56   0:00 tini /bin/bash -- -c id -a; date; ps faux
ubuntu      48  0.0  0.0  18376  2968 ?        S    13:56   0:00 /bin/bash -c id -a; date; ps faux
ubuntu      51  0.0  0.0  34400  2860 ?        R    13:56   0:00  \_ ps faux

```

## Usage
<span data-message="dockerhub formatting fix"></span>
### Docker

```
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v /etc/localtime:/etc/localtime:ro \
  andrewmackrodt/<image>
```

### Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e TZ=UTC` | The timezone, e.g. `Europe/London` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |

## Development

### Build and Push

```
./configure
make
make push
```

### Parameters

Container specific parameters which should not be overridden at runtime.

| Parameter | Function |
| --- | --- |
| `ENTRYPOINT0=` | Executed after `docker-entrypoint.sh` if `CMD` is empty or begins with "-" |
| `S6_ENABLE=0` | <p>`s6-overlay` init configuration:</p><ul><li>0: disabled</li><li>1: always</li><li>2: `CMD` is empty</li></ul> |
| `USER_DIRS=` | Directories to be recursively chowned to $PUID:GUID on container start |
