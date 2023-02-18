FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add smplayer repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:rvm/smplayer || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show smplayer \
            | sed -nE 's/^Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
 && rm -rf /var/lib/apt/lists/*

ARG SMPLAYER_VERSION

# install smplayer
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      smplayer=$SMPLAYER_VERSION \
      smplayer-themes \
 && rm -rf /var/lib/apt/lists/*

# create smplayer directories
RUN for d in /config /videos; do \
      mkdir "$d"; \
      chgrp adm "$d"; \
      chmod 2775 "$d"; \
    done

# copy files to container
COPY smplayer-bootstrap /usr/local/bin/smplayer-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link /config to smplayer config
RUN mkdir -p /home/ubuntu/.config \
 && ln -s /config /home/ubuntu/.config/smplayer

# link /videos to ubuntu user home directory
RUN ln -s /videos /home/ubuntu/Videos

# export volumes
VOLUME /config

# set directories to be chowned on container start
ENV USER_DIRS /config${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/smplayer-bootstrap

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
