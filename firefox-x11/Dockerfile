FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add mozillateam/ppa repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:mozillateam/ppa || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && rm -rf /var/lib/apt/lists/* \
 && /bin/echo -e 'Package: firefox*\nPin: release o=Ubuntu*\nPin-Priority: -1' >/etc/apt/preferences.d/mozilla-firefox

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show firefox \
            | sed -nE 's/Depends: //p' \
            | grep -v debconf \
            | tail -n1 \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
        ) \
      libavcodec58 \
      libdbusmenu-gtk3-4 \
 && rm -rf /var/lib/apt/lists/*

ARG FIREFOX_VERSION

# install firefox
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends firefox=$FIREFOX_VERSION \
 && rm -rf /var/lib/apt/lists/*

# link /data to firefox config
RUN mkdir /data \
 && chgrp adm /data \
 && chmod 2770 /data \
 && ln -s /data /home/ubuntu/.mozilla \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/.mozilla

# link /downloads to home
RUN mkdir /downloads \
 && chgrp adm /downloads \
 && chmod 2770 /downloads \
 && rmdir /home/ubuntu/Downloads 2>/dev/null || true \
 && ln -s /downloads /home/ubuntu/Downloads \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/Downloads

# copy files to container
COPY firefox-bootstrap /usr/local/bin/firefox-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# export volumes
VOLUME /data
VOLUME /downloads

# set directories to be chowned on container start
ENV USER_DIRS /data:/downloads${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/firefox-bootstrap

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
