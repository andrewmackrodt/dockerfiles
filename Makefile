build:
	cd ubuntu; make build
	cd chromium; make build
	cd buildpack-deps; make build
	cd nodejs; make build
	cd nodejs-chromium; make build

push:
	cd ubuntu; make release
	cd chromium; make release
	cd buildpack-deps; make release
	cd nodejs; make release
	cd nodejs-chromium; make release
