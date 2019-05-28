SHELL=/bin/bash

# registry args
REGISTRY_HOST=docker.io
USERNAME=andrewmackrodt

SUPPORT_FUNCTIONS := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/.make-support

# image args
NAME=$(shell basename $(CURDIR))
IMAGE=$(REGISTRY_HOST)/$(USERNAME)/$(NAME)
VERSION=$(shell . $(SUPPORT_FUNCTIONS) ; getVersion)
VERSION_MAJOR_MINOR=$(shell . $(SUPPORT_FUNCTIONS) ; getVersionMajorMinor)
VERSION_MAJOR=$(shell . $(SUPPORT_FUNCTIONS) ; getVersionMajor)

# VCS LABEL build args
VCS_NAME=$(shell basename $$(dirname $(abspath $(lastword $(MAKEFILE_LIST)))))
VCS_HOST=github.com
VCS_URL=https://$(VCS_HOST)/$(USERNAME)/$(VCS_NAME)
VCS_REF=$(shell . $(SUPPORT_FUNCTIONS) ; getVcsRef)

DOCKER_BUILD_ARGS_LABEL=\
	--build-arg "LABEL_NAME=$(NAME)" \
	--build-arg "VERSION=$(VERSION)" \
	--build-arg "LABEL_DESCRIPTION=" \
	--build-arg "LABEL_USAGE=https://$(VCS_HOST)/$(USERNAME)/$(VCS_NAME)/tree/master/$(NAME)" \
	--build-arg "LABEL_VENDOR=$(USERNAME)" \
	--build-arg "LABEL_VCS_URL=$(VCS_URL)" \
	--build-arg "LABEL_VCS_REF=$(VCS_REF)"

DOCKER_BUILD_ARGS=$(shell . $(SUPPORT_FUNCTIONS) ; getBuildArgs)
DOCKER_BUILD_CONTEXT=.
DOCKER_FILE_PATH=Dockerfile

.PHONY: build pre-build do-build post-build \
	    push pre-push do-push post-push \
	    clean

build: pre-build do-build post-build

pre-build:

do-build: build.properties
	docker build \
		$(DOCKER_BUILD_ARGS_LABEL) \
		$(DOCKER_BUILD_ARGS) \
	    -t $(IMAGE):$(VERSION_MAJOR) \
	    -t $(IMAGE):$(VERSION_MAJOR_MINOR) \
	    -t $(IMAGE):$(VERSION) \
	    -t $(IMAGE):latest \
	    $(DOCKER_BUILD_CONTEXT) \
	    -f $(DOCKER_FILE_PATH)

post-build:

push: pre-push do-push post-push

pre-push:

do-push: build.properties
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest

post-push:

clean:
	rm -f build.properties

build.properties:
	$(shell . $(SUPPORT_FUNCTIONS) ; configure)
