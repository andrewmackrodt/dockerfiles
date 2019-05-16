$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "REDREAM_VERSION=$(REDREAM_VERSION)"

include ../Makefile.mk
