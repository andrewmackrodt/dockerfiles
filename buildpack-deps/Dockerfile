FROM andrewmackrodt/ubuntu

ARG LABEL_NAME
ARG LABEL_VERSION
ARG LABEL_USAGE
ARG LABEL_VENDOR
ARG LABEL_VCS_URL
ARG LABEL_VCS_REF

LABEL org.label-schema.name="$LABEL_NAME" \
  org.label-schema.version="$LABEL_VERSION" \
  org.label-schema.usage="$LABEL_USAGE" \
  org.label-schema.vendor="$LABEL_VENDOR" \
  org.label-schema.vcs-url="$LABEL_VCS_URL" \
  org.label-schema.vcs-ref="$LABEL_VCS_REF" \
  org.label-schema.schema-version="1.0"

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# adapted from [buildpack-deps:bionic](https://hub.docker.com/_/buildpack-deps/)
# @see https://github.com/docker-library/buildpack-deps/blob/ff09b5c/bionic/Dockerfile
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      autoconf \
      automake \
      bzip2 \
      dpkg-dev \
      file \
      g++ \
      gcc \
      imagemagick \
      libbz2-dev \
      libc6-dev \
      libcurl4-openssl-dev \
      libdb-dev \
      libevent-dev \
      libffi-dev \
      libgdbm-dev \
      libgeoip-dev \
      libglib2.0-dev \
      libgmp-dev \
      libjpeg-turbo8-dev \
      libkrb5-dev \
      liblzma-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmysqlclient-dev \
      libncurses5-dev \
      libncursesw5-dev \
      libpng-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libtool \
      libwebp-dev \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      make \
      patch \
      unzip \
      xz-utils \
      zlib1g-dev \
      ca-certificates \
      curl \
      git \
      jq \
      nasm \
      rsync \
 && rm -rf /var/lib/apt/lists/*

# add yq
RUN ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -qO /tmp/release.json "https://api.github.com/repos/mikefarah/yq/releases/latest" \
 && grep -E '"browser_download_url":.+linux.*'$ARCH'' /tmp/release.json | grep -v -E ".(asc|sig)" | head -n1 | cut -d '"' -f4 > /tmp/release.txt \
 && wget -qO /usr/local/bin/yq "$(cat /tmp/release.txt)" \
 && chmod +x /usr/local/bin/yq \
 && rm -f /tmp/release.*

USER ubuntu
WORKDIR /home/ubuntu
