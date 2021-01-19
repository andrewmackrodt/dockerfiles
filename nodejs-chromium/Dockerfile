FROM andrewmackrodt/nodejs:lts

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
 && rm -rf /var/lib/apt/lists/*

ARG LABEL_VERSION

# install chromium-browser
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends chromium-browser \
 && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium-browser
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

USER ubuntu
WORKDIR /home/ubuntu

################################################################################
# labels
################################################################################

ARG LABEL_NAME
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
