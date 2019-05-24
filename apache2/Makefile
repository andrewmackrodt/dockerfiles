$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "APACHE_VERSION=$(APACHE_VERSION)"

include ../Makefile.mk
