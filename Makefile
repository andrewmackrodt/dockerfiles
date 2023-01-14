build:
	cd ubuntu; make build
	cd php; make build
	cd php-apache2; make build
	cd apache2; make build
	cd python; make build
	cd buildpack-deps; make build
	cd buildpack-dind; make build
	cd nodejs; make build
	cd nodejs-chromium; make build
	cd google-cloud-sdk; make build
	cd firebase-tools; make build
	cd ubuntu-x11; make build
	cd ubuntu-x11-i386; make build
	cd smplayer-x11; make build
	cd firefox-x11; make build
	cd chromium-x11; make build
	cd spotify-x11; make build
	cd redream-x11; make build
	cd dolphin-emu-x11; make build
	cd pcsx2-x11; make build
	cd yabasanshiro-x11; make build

push:
	cd ubuntu; make push
	cd php; make push
	cd php-apache2; make push
	cd apache2; make push
	cd python; make push
	cd buildpack-deps; make push
	cd buildpack-dind; make push
	cd nodejs; make push
	cd nodejs-chromium; make push
	cd google-cloud-sdk; make push
	cd firebase-tools; make push
	cd ubuntu-x11; make push
	cd ubuntu-x11-i386; make push
	cd smplayer-x11; make push
	cd firefox-x11; make push
	cd chromium-x11; make push
	cd spotify-x11; make push
	cd redream-x11; make push
	cd dolphin-emu-x11; make push
	cd pcsx2-x11; make push
	cd yabasanshiro-x11; make push

release:
	cd ubuntu; make build && make push
	cd php; make build && make push
	cd php-apache2; make build && make push
	cd apache2; make build && make push
	cd python; make build && make push
	cd buildpack-deps; make build && make push
	cd buildpack-dind; make build && make push
	cd nodejs; make build && make push
	cd nodejs-chromium; make build && make push
	cd google-cloud-sdk; make build && make push
	cd firebase-tools; make build && make push
	cd ubuntu-x11; make build && make push
	cd ubuntu-x11-i386; make build && make push
	cd smplayer-x11; make build && make push
	cd firefox-x11; make build && make push
	cd chromium-x11; make build && make push
	cd spotify-x11; make build && make push
	cd redream-x11; make build && make push
	cd dolphin-emu-x11; make build && make push
	cd pcsx2-x11; make build && make push
	cd yabasanshiro-x11; make build && make push

docs:
	cd ubuntu; make docs
	cd php; make docs
	cd php-apache2; make docs
	cd apache2; make docs
	cd python; make docs
	cd buildpack-deps; make docs
	cd buildpack-dind; make docs
	cd nodejs; make docs
	cd nodejs-chromium; make docs
	cd google-cloud-sdk; make docs
	cd firebase-tools; make docs
	cd fossilize; make docs
	cd objection; make docs
	cd ubuntu-x11; make docs
	cd ubuntu-x11-i386; make docs
	cd smplayer-x11; make docs
	cd firefox-x11; make docs
	cd chromium-x11; make docs
	cd spotify-x11; make docs
	cd redream-x11; make docs
	cd dolphin-emu-x11; make docs
	cd pcsx2-x11; make docs
	cd yabasanshiro-x11; make docs

clean:
	cd ubuntu; make clean
	cd php; make clean
	cd php-apache2; make clean
	cd apache2; make clean
	cd python; make clean
	cd buildpack-deps; make clean
	cd buildpack-dind; make clean
	cd nodejs; make clean
	cd nodejs-chromium; make clean
	cd google-cloud-sdk; make clean
	cd firebase-tools; make clean
	cd fossilize; make clean
	cd objection; make clean
	cd ubuntu-x11; make clean
	cd ubuntu-x11-i386; make clean
	cd smplayer-x11; make clean
	cd firefox-x11; make clean
	cd chromium-x11; make clean
	cd spotify-x11; make clean
	cd redream-x11; make clean
	cd dolphin-emu-x11; make clean
	cd pcsx2-x11; make clean
	cd yabasanshiro-x11; make clean
