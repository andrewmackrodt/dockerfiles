build:
	cd ubuntu; make build
	cd ubuntu-x11; make build
	cd ubuntu-x11-i386; make build
	cd chromium-x11; make build
	cd firefox-x11; make build
	cd spotify-x11; make build
	cd redream-x11; make build
	cd dolphin-emu-x11; make build
	cd pcsx2-x11; make build
	cd buildpack-deps; make build
	cd nodejs; make build
	cd nodejs-chromium; make build
	cd apache2; make build
	cd php; make build
	cd php-apache2; make build

push:
	cd ubuntu; make push
	cd ubuntu-x11; make push
	cd ubuntu-x11-i386; make push
	cd chromium-x11; make push
	cd firefox-x11; make push
	cd spotify-x11; make push
	cd redream-x11; make push
	cd dolphin-emu-x11; make push
	cd pcsx2-x11; make push
	cd buildpack-deps; make push
	cd nodejs; make push
	cd nodejs-chromium; make push
	cd apache2; make push
	cd php; make push
	cd php-apache2; make push
