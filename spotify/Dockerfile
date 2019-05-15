FROM andrewmackrodt/ubuntu-x11:18.04

ARG LABEL_NAME
ARG LABEL_VERSION
ARG LABEL_DESCRIPTION
ARG LABEL_BUILD_DATE
ARG LABEL_USAGE
ARG LABEL_VENDOR
ARG LABEL_VCS_URL
ARG LABEL_VCS_REF

LABEL org.label-schema.name="$LABEL_NAME" \
  org.label-schema.version="$LABEL_VERSION" \
  org.label-schema.description="$LABEL_DESCRIPTION" \
  org.label-schema.build-date="$LABEL_BUILD_DATE" \
  org.label-schema.usage="$LABEL_USAGE" \
  org.label-schema.vendor="$LABEL_VENDOR" \
  org.label-schema.vcs-url="$LABEL_VCS_URL" \
  org.label-schema.vcs-ref="$LABEL_VCS_REF" \
  org.label-schema.schema-version="1.0"

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive
ARG SPOTIFY_VERSION

# add spotify repository
RUN apt-get update -qq \
 && apt-get install -qqy \
      software-properties-common \
      gnupg \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A87FF9DF48BF1C90 \
 && add-apt-repository "deb http://repository.spotify.com stable non-free" \
 && apt-get purge -qqy --auto-remove \
      software-properties-common \
      gnupg \
 && rm -rf /var/lib/apt/lists/*

# install spotify
RUN apt-get update -qq \
 && apt-get install -qqy \
      spotify-client=$SPOTIFY_VERSION \
 && rm -rf /var/lib/apt/lists/*

# link /config to spotify config
RUN mkdir /config /home/ubuntu/.config \
 && chgrp adm /config \
 && chmod 2770 /config \
 && ln -s /config /home/ubuntu/.config/spotify \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.config

# link /cache to spotify cache
RUN mkdir /cache /home/ubuntu/.cache \
 && chgrp adm /cache \
 && chmod 2770 /cache \
 && ln -s /cache /home/ubuntu/.cache/spotify \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.cache

ENV ENTRYPOINT0 /usr/bin/spotify

USER ubuntu
WORKDIR /home/ubuntu
