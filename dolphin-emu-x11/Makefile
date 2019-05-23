$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "DOLPHIN_EMU_VERSION=$(DOLPHIN_EMU_VERSION)"

include ../Makefile.mk
