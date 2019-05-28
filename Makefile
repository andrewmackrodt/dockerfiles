build:
	cd ubuntu; make build
	cd php; make build
	cd php-apache2; make build
	cd apache2; make build
	cd buildpack-deps; make build
	cd nodejs; make build
	cd nodejs-chromium; make build
	cd ubuntu-x11; make build
	cd ubuntu-x11-i386; make build
	cd firefox-x11; make build
	cd chromium-x11; make build
	cd spotify-x11; make build
	cd redream-x11; make build
	cd dolphin-emu-x11; make build
	cd pcsx2-x11; make build

push:
	cd ubuntu; make push
	cd php; make push
	cd php-apache2; make push
	cd apache2; make push
	cd buildpack-deps; make push
	cd nodejs; make push
	cd nodejs-chromium; make push
	cd ubuntu-x11; make push
	cd ubuntu-x11-i386; make push
	cd firefox-x11; make push
	cd chromium-x11; make push
	cd spotify-x11; make push
	cd redream-x11; make push
	cd dolphin-emu-x11; make push
	cd pcsx2-x11; make push

clean:
	cd ubuntu; make clean
	cd php; make clean
	cd php-apache2; make clean
	cd apache2; make clean
	cd buildpack-deps; make clean
	cd nodejs; make clean
	cd nodejs-chromium; make clean
	cd ubuntu-x11; make clean
	cd ubuntu-x11-i386; make clean
	cd firefox-x11; make clean
	cd chromium-x11; make clean
	cd spotify-x11; make clean
	cd redream-x11; make clean
	cd dolphin-emu-x11; make clean
	cd pcsx2-x11; make clean
