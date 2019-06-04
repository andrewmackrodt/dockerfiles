FROM andrewmackrodt/ubuntu-x11-i386

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add PCSX2 repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      software-properties-common \
 && add-apt-repository -y ppa:pcsx2-team/pcsx2-daily \
 && apt-get purge -qqy --auto-remove \
      software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show pcsx2-unstable \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
      libcap2-bin \
      locales \
      rtkit \
      unzip \
 && rm -rf /var/lib/apt/lists/*

ARG PCSX2_VERSION

# install PCSX2
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends pcsx2-unstable=$PCSX2_VERSION \
 && rm -rf /var/lib/apt/lists/*

# add ubuntu user to rtkit to access input devices
RUN adduser ubuntu rtkit

# create PCSX2 directories
RUN for d in /games /data /bios /plugins; do \
      mkdir "$d"; \
      chgrp adm "$d"; \
      chmod 2775 "$d"; \
    done

# add PCSX2 bin to path
RUN ln -s /usr/games/PCSX2 /usr/local/bin/PCSX2

# copy files to container
COPY pcsx2-bootstrap /usr/local/bin/pcsx2-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link /data to PCSX2 config
RUN mkdir -p /home/ubuntu/.config \
 && ln -s /data /home/ubuntu/.config/PCSX2

# create .local/share for recently-used.xbel
RUN mkdir -p /home/ubuntu/.local/share

# export volumes
VOLUME /data
VOLUME /bios
VOLUME /plugins

# set directories to be chowned on container start
ENV USER_DIRS /data:/bios:/plugins${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/pcsx2-bootstrap

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
