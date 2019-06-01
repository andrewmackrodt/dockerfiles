FROM andrewmackrodt/ubuntu-x11

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
ARG DOLPHIN_EMU_VERSION

# add dolphin-emu repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      software-properties-common \
 && add-apt-repository -y ppa:dolphin-emu/ppa \
 && apt-get purge -qqy --auto-remove \
      software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show dolphin-emu-master \
            | sed -nE 's/Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
 && rm -rf /var/lib/apt/lists/*

# install dolphin-emu
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      dolphin-emu-master=$DOLPHIN_EMU_VERSION \
 && rm -rf /var/lib/apt/lists/*

# create dolphin-emu directories
RUN for d in /gc /wii /config /data; do \
      mkdir "$d"; \
      chgrp adm "$d"; \
      chmod 2775 "$d"; \
    done

# add dolphin-emu bin to path
RUN ln -s /usr/games/dolphin-emu /usr/local/bin/dolphin-emu

# copy files to container
COPY dolphin-emu-bootstrap /usr/local/bin/dolphin-emu-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link /config
RUN mkdir -p /home/ubuntu/.config \
 && ln -s /config /home/ubuntu/.config/dolphin-emu

# link /data
RUN mkdir -p /home/ubuntu/.local/share \
 && ln -s /data /home/ubuntu/.local/share/dolphin-emu

# export volumes
VOLUME /config
VOLUME /data

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/dolphin-emu-bootstrap
