# [andrewmackrodt/docker-php](https://github.com/andrewmackrodt/dockerfiles/tree/master/php)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fphp)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/php.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/php/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/php)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/php)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/php/
[pulls]: https://hub.docker.com/r/andrewmackrodt/php
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/php/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/php
[version]: https://hub.docker.com/r/andrewmackrodt/php/tags

[PHP](https://php.net/) is a popular general-purpose scripting language that is
especially suited to web development. Fast, flexible and pragmatic, PHP powers
everything from your blog to the most popular websites in the world.

## Versions

PHP `8.4` is tagged as `latest`. Images for versions `5.6` -> `8.3` are also provided:

- <strike>`andrewmackrodt/php:5.6` Legacy (end-of-life: 2018-12-31)</strike>
- <strike>`andrewmackrodt/php:7.0` Legacy (end-of-life: 2019-01-10)</strike>
- <strike>`andrewmackrodt/php:7.1` Legacy (end-of-life: 2019-12-01)</strike>
- <strike>`andrewmackrodt/php:7.2` Legacy (end-of-life: 2020-11-30)</strike>
- <strike>`andrewmackrodt/php:7.3` Legacy (end-of-life: 2021-12-06)</strike>
- <strike>`andrewmackrodt/php:7.4` Legacy (end-of-life: 2022-11-28)</strike>
- <strike>`andrewmackrodt/php:8.0` Legacy (end-of-life: 2023-11-26)</strike>
- `andrewmackrodt/php:8.1` Security Support (end-of-life: 2025-12-31)
- `andrewmackrodt/php:8.2` Security Support (end-of-life: 2026-12-31)
- `andrewmackrodt/php:8.3` Latest (end-of-life: 2027-12-31)
- `andrewmackrodt/php:8.4` Latest (end-of-life: 2028-12-31)

**Update Schedule**

Images are built nightly and images will be updated as new `major.minor.patch-release`
packages of PHP are released. It's possible to pull a specific tag, e.g.
`docker pull andrewmackrodt/php:7.3.24-r3`, see [Docker Hub][hub] for a list of
supported tags.

[hub]: https://hub.docker.com/r/andrewmackrodt/php/tags

**Removal Policy**

Old tags are subject to removal periodically without notice.

## Features

All images include [composer](https://getcomposer.org/).

**Extensions:**
- Core: `cli`, `common`, `dev`, `readline`, `json`, `curl`
- Compression: `bz2`, `zip`
- Database: `mysql`, `pgsql`, `sqlite3`, `memcached`, `redis`
- Debug: <em>`xdebug (set env.XDEBUG_ENABLE=1)`</em>
- Math: `bcmath`, `gmp`
- Performance: `igbinary`, `opcache`
- Other: `gd`, `imap`, `intl`, `mbstring`, `soap`, `xml`, `xsl`
- Legacy: <em>`mcrypt (PHP <= 7.1)`</em>

## Usage
<span data-message="dockerhub formatting fix"></span>
### docker

```
# start interactive mode
docker run --rm -it andrewmackrodt/php -a

# print version
docker run --rm andrewmackrodt/php --version

# print version with xdebug
docker run --rm -e XDEBUG_ENABLE=1 andrewmackrodt/php --version

# start the builtin server with xdebug enabled, on port 8080 and serving the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e XDEBUG_ENABLE=1 \
  -p 8080:8080 \
  -v $PWD:/app \
  andrewmackrodt/php -S 0.0.0.0:8080 -t /app

# run composer install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/php composer install
```

## Parameters

| Parameter            | Function                              |
|----------------------|---------------------------------------|
| `-e PUID=1000`       | The user id, recommended: `$(id -u)`  |
| `-e PGID=1000`       | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e XDEBUG_ENABLE=0` | Set to "1" to enable xdebug           |
