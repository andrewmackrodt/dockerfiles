$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "CHROMIUM_VERSION=$(CHROMIUM_VERSION)"

include ../Makefile.mk
