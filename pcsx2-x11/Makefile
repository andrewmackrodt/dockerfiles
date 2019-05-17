$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "PCSX2_VERSION=$(PCSX2_VERSION)"

include ../Makefile.mk
