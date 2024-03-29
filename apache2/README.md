# [andrewmackrodt/docker-apache2](https://github.com/andrewmackrodt/dockerfiles/tree/master/apache2)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fapache2)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/apache2.svg)][pulls]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/apache2/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Size](https://img.shields.io/docker/image-size/andrewmackrodt/apache2)][size]
[![Version](https://img.shields.io/docker/v/andrewmackrodt/apache2)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/apache2/
[pulls]: https://hub.docker.com/r/andrewmackrodt/apache2
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/apache2/Dockerfile
[size]: https://microbadger.com/images/andrewmackrodt/apache2
[version]: https://hub.docker.com/r/andrewmackrodt/apache2/tags

[Apache][apache] HTTP Server Project is an effort to develop and maintain an
open-source HTTP server for modern operating systems including UNIX and
Windows. A secure, efficient and extensible server that provides HTTP services
in sync with the current HTTP standards.

[apache]: http://httpd.apache.org/

## Features

[Apache HTTP Server Version 2.4](https://httpd.apache.org/docs/2.4/).

- [Let's Encrypt](https://letsencrypt.org/) certificate generation and renewal
- `X-Forwarded-For` support for default docker subnet
- AllowOverride all configured in `/var/www`
- Directory Indexes forbidden in `/var/www`
- `www-data` uses the same `UID` as the `ubuntu` account
- Modules: `rewrite`, `headers`, `ssl`, `remoteip`

## Usage

_`LETS_ENCRYPT_` environment variables are optional._

### docker

```
# create the container
docker create \
  --name mysite \
  -p 8080:80 \
  -p 8443:443 \
  -e PUID=$(id -u) \
  -e PGID=(id -g) \
  -e LETS_ENCRYPT_DOMAINS=97e0973.ngrok.io \
  -e LETS_ENCRYPT_EMAIL=you@mysite.com \
  -e LETS_ENCRYPT_STAGING=0 \
  -v $HOME/public_html:/var/www/html \
  -v $HOME/.certbot/mysite:/etc/letsencrypt/live \
  andrewmackrodt/apache2
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-p 8080:80` | Expose port 80 on the host |
| `-p 8443:443` | Expose port 443 on the host |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e SUDO_NOPASSWD=0` | Set to `1` to allow passwordless sudo |
| `-e LETS_ENCRYPT_DOMAINS=` | Domain's to request certificates for, comma separated |
| `-e LETS_ENCRYPT_EMAIL=` | E-mail address to receive Let's Encrypt Notifications |
| `-e LETS_ENCRYPT_STAGING=0` | Set to "1" to use staging server |
| `-v /var/www/html` | Apache DocumentRoot |
| `-v /etc/letsencrypt/live` | Certbot Let's Encrypt directory |
