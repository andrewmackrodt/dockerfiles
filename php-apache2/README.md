# [andrewmackrodt/docker-php-apache2](https://github.com/andrewmackrodt/dockerfiles/tree/master/php-apache2)

[![Status](https://jenkins.mackrodt.io/buildStatus/icon?job=dockerfiles%2Fphp-apache2)][status]
[![Pulls](https://img.shields.io/docker/pulls/andrewmackrodt/php-apache2.svg)][pulls]
[![Layers](https://images.microbadger.com/badges/image/andrewmackrodt/php-apache2.svg)][layers]
[![Dockerfile](https://img.shields.io/github/size/andrewmackrodt/dockerfiles/php-apache2/Dockerfile.svg?label=dockerfile)][dockerfile]
[![Version](https://images.microbadger.com/badges/version/andrewmackrodt/php-apache2.svg)][version]

[status]: https://jenkins.mackrodt.io/job/dockerfiles/job/php-apache2/
[pulls]: https://hub.docker.com/r/andrewmackrodt/php-apache2
[layers]: https://microbadger.com/images/andrewmackrodt/php-apache2
[dockerfile]: https://github.com/andrewmackrodt/dockerfiles/blob/master/php-apache2/Dockerfile
[version]: https://hub.docker.com/r/andrewmackrodt/php-apache2/tags

Combined [PHP][php] + [Apache2][apache2] image using mod_php. This image is
recommended for backend applications such as APIs which do not need to serve
static assets. While it will work for small to medium sized general purpose
applications like WordPress, it will not perform as well as a [php-fpm][fpm]
configuration due to the way that Apache prefork functions.

[php]: https://github.com/andrewmackrodt/dockerfiles/tree/master/php
[apache2]: https://github.com/andrewmackrodt/dockerfiles/tree/master/apache2
[fpm]: https://php-fpm.org/

## Features

**[Apache HTTP Server Version 2.4](https://httpd.apache.org/docs/2.4/)**
- [Let's Encrypt](https://letsencrypt.org/) certificate generation and renewal
- `X-Forwarded-For` support for default docker subnet
- AllowOverride all configured in `/var/www`
- Directory Indexes forbidden in `/var/www`
- `www-data` uses the same `UID` as the `ubuntu` account
- Modules: `rewrite`, `headers`, `ssl`, `remoteip`

**[PHP 7.3](https://www.php.net/releases/7_3_0.php)** and the latest version of
**[composer](https://getcomposer.org/)** as of the image build date.

**Extensions:**
- Core: `cli`, `common`, `dev`, `readline`, `json`, `curl`
- Compression: `bz2`, `zip`
- Database: `mysql`, `pgsql`, `sqlite3`, `memcached`, `redis`
- Debug: `xdebug`\*
- Math: `bcmath`, `gmp`
- Performance: `igbinary`, `opcache`
- Other: `gd`, `imap`, `intl`, `mbstring`, `soap`, `xml`, `xsl`

\* xdebug is only enabled if the environment variable `XDEBUG_ENABLE=1`.

## Usage

_`LETS_ENCRYPT_` environment variables are optional._

See also [andrewmackrodt/php][php] and [andrewmackrodt/apache2][apache2].

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
  -e XDEBUG_ENABLE=0 \
  -v $HOME/public_html:/var/www/html \
  -v $HOME/.certbot/mysite:/etc/letsencrypt/live \
  andrewmackrodt/php-apache2
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
| `-e XDEBUG_ENABLE=0` | Set to "1" to enable xdebug |
| `-v /var/www/html` | Apache DocumentRoot |
| `-v /etc/letsencrypt/live` | Certbot Let's Encrypt directory |
