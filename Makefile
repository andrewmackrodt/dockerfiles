build:
	cd ubuntu; make build
	cd chromium; make build
	cd buildpack-deps; make build
	cd nodejs; make build
	cd nodejs-chromium; make build

push:
	cd ubuntu; make push
	cd chromium; make push
	cd buildpack-deps; make push
	cd nodejs; make push
	cd nodejs-chromium; make push
