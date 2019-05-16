$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "FIREFOX_VERSION=$(FIREFOX_VERSION)"

include ../Makefile.mk
