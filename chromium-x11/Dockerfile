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
ARG CHROMIUM_VERSION

# install chromium
RUN apt-get update -qq \
 && apt-get install -qqy \
      chromium-browser=$CHROMIUM_VERSION \
      alsa-utils \
      notify-osd \
 && rm -rf /var/lib/apt/lists/*

# link /data to chrome config
RUN mkdir /data \
 && chgrp adm /data \
 && chmod 2770 /data \
 && mkdir /home/ubuntu/.config \
 && ln -s /data /home/ubuntu/.config/chromium \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.config

# link /downloads to home
RUN mkdir /downloads \
 && chgrp adm /downloads \
 && chmod 2770 /downloads \
 && rmdir /home/ubuntu/Downloads 2>/dev/null || true \
 && ln -s /downloads /home/ubuntu/Downloads \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/Downloads

# copy files to container
COPY chromium-bootstrap /usr/local/bin/chromium-bootstrap

ENV ENTRYPOINT0 /usr/local/bin/chromium-bootstrap

USER ubuntu
WORKDIR /home/ubuntu
