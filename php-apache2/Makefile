$(shell . "$(CURDIR)/.make-release-support" ; configure )

include $(CURDIR)/.release.env

DOCKER_BUILD_ARGS=\
	--build-arg "PHP_VERSION=$(PHP_VERSION)"

include ../Makefile.mk
