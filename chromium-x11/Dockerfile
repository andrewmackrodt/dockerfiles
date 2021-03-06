FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# pin chromium-browser package from bionic-updates
# https://askubuntu.com/a/1286743/170380
RUN echo "deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe" > /etc/apt/sources.list.d/bionic-updates.list \
 && echo "Package: chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra chromium-codecs-ffmpeg" > /etc/apt/preferences.d/chromium-browser-deb \
 && echo "Pin: release a=bionic-updates" >> /etc/apt/preferences.d/chromium-browser-deb \
 && echo "Pin-Priority: 900" >> /etc/apt/preferences.d/chromium-browser-deb

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show chromium-browser \
            | sed -nE 's/^Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
            | sort \
            | uniq \
        ) \
      libdbusmenu-gtk3-4 \
      locales \
      notify-osd \
 && rm -rf /var/lib/apt/lists/*

ARG CHROMIUM_VERSION

# install chromium
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends chromium-browser=$CHROMIUM_VERSION \
 && rm -rf /var/lib/apt/lists/*

# link /data to chrome config
RUN mkdir /data \
 && chgrp adm /data \
 && chmod 2770 /data \
 && mkdir -p /home/ubuntu/.config \
 && ln -s /data /home/ubuntu/.config/chromium \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.config

# link /downloads to home
RUN mkdir /downloads \
 && chgrp adm /downloads \
 && chmod 2770 /downloads \
 && rmdir /home/ubuntu/Downloads 2>/dev/null || true \
 && ln -s /downloads /home/ubuntu/Downloads \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/Downloads

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# export volumes
VOLUME /data
VOLUME /downloads

# set directories to be chowned on container start
ENV USER_DIRS /data:/downloads${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/bin/chromium-browser

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
