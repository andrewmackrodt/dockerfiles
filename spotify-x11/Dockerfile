FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add spotify repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common gnupg \
 && wget -qO- https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | apt-key add - \
 && add-apt-repository "deb http://repository.spotify.com stable non-free" \
 && apt-get purge -qqy --auto-remove software-properties-common gnupg \
 && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show spotify-client \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
 && rm -rf /var/lib/apt/lists/*

ARG SPOTIFY_VERSION

# install spotify-client
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends spotify-client=$SPOTIFY_VERSION \
 && rm -rf /var/lib/apt/lists/*

# link /config to spotify config
RUN mkdir -p /config /home/ubuntu/.config \
 && chgrp adm /config \
 && chmod 2770 /config \
 && ln -s /config /home/ubuntu/.config/spotify \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.config

# link /cache to spotify cache
RUN mkdir -p /cache /home/ubuntu/.cache \
 && chgrp adm /cache \
 && chmod 2770 /cache \
 && ln -s /cache /home/ubuntu/.cache/spotify \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.cache

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# export volumes
VOLUME /config
VOLUME /cache

# set directories to be chowned on container start
ENV USER_DIRS /config:/cache${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/bin/spotify

################################################################################
# labels
################################################################################

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
