# [andrewmackrodt/docker-php](https://github.com/andrewmackrodt/dockerfiles/tree/master/php)

[PHP](https://php.net/) is a popular general-purpose scripting language that is
especially suited to web development. Fast, flexible and pragmatic, PHP powers
everything from your blog to the most popular websites in the world.

## Features

[PHP 7.3](https://www.php.net/releases/7_3_0.php) and the latest version of
[composer](https://getcomposer.org/) as of the image build date.

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

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
| `-e XDEBUG_ENABLE=0` | Set to "1" to enable xdebug |
