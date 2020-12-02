FROM andrewmackrodt/python:2.7

USER root
WORKDIR /root

# install libspotify
RUN wget -q -O libspotify-12.1.51-Linux-x86_64-release.tar.gz "https://raw.githubusercontent.com/mopidy/libspotify-archive/master/libspotify-12.1.51-Linux-x86_64-release.tar.gz" \
 && tar zxfh libspotify-12.1.51-Linux-x86_64-release.tar.gz -C /opt \
 && rm -f libspotify-12.1.51-Linux-x86_64-release.tar.gz \
 && cd /opt/libspotify-12.1.51-Linux-x86_64-release \
 && make install prefix=/usr/local \
 && cd /root \
 && rm -rf /opt/libspotify-12.1.51-Linux-x86_64-release

# install spotify-ripper
ARG SPOTIFY_RIPPER_VERSION

RUN git clone https://github.com/hbashton/spotify-ripper \
 && cd spotify-ripper \
 && git checkout "$SPOTIFY_RIPPER_VERSION" \
 && python setup.py install \
 && cd /root \
 && rm -rf spotify-ripper

ARG DEBIAN_FRONTEND=noninteractive

# install additional encoding formats
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      flac \
      faac \
      lame \
      vorbis-tools \
      opus-tools \
 && rm -rf /var/lib/apt/lists/*

# link /music to ubuntu user home
RUN mkdir /music \
 && chgrp adm /music \
 && chmod 2770 /music \
 && ln -s /music /home/ubuntu/Music \
 && chown -h -R ubuntu:ubuntu /home/ubuntu/Music

USER ubuntu
WORKDIR /home/ubuntu/Music

# download spotify_appkey.key
RUN mkdir -p /home/ubuntu/.spotify-ripper \
 && wget -q -O /home/ubuntu/.spotify-ripper/spotify_appkey.key "https://raw.githubusercontent.com/joowdx/spotify_appkey/master/spotify_appkey.key"

# export volumes
VOLUME /music

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/spotify-ripper

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
