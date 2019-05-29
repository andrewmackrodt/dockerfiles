# [andrewmackrodt/docker-nodejs](https://github.com/andrewmackrodt/dockerfiles/tree/master/nodejs)

[Node.js](https://nodejs.org/) is a JavaScript runtime built on Chrome's V8 JavaScript engine.

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
docker run --rm -it andrewmackrodt/nodejs

# print version
docker run --rm andrewmackrodt/nodejs --version

# run npm install in the current directory
docker run --rm -it \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -v $PWD:/app \
  -w /app \
  andrewmackrodt/nodejs npm install
```

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=1000` | The user id, recommended: `$(id -u)` |
| `-e PGID=1000` | The group id, recommended: `$(id -g)` |
