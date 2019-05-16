$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "SPOTIFY_VERSION=$(SPOTIFY_VERSION)"

include ../Makefile.mk
