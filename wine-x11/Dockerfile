FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      cabextract \
      libegl-mesa0 \
      libsdl2.2 \
      libvulkan1 \
      p7zip-full \
      unzip \
      xinput \
      xz-utils \
      winbind \
      zenity \
 && rm -rf /var/lib/apt/lists/*

# add wine gpg key
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends gnupg \
 && mkdir /root/.gnupg \
 && echo 'disable-ipv6' >> /root/.gnupg/dirmngr.conf \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 76F1A20FF987672F \
 && apt-get purge -qqy --auto-remove gnupg \
 && rm -rf /var/lib/apt/lists/* /root/.gnupg

ARG WINE_BRANCH=staging
ENV WINE_BRANCH=$WINE_BRANCH
ARG WINE_VERSION

# install wine
RUN echo "deb https://dl.winehq.org/wine-builds/ubuntu/ $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/wine.list \
 && dpkg --add-architecture i386 \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends "winehq-$WINE_BRANCH${WINE_VERSION:+=$WINE_VERSION}" \
 && rm -rf /var/lib/apt/lists/*

# add winetricks
RUN wget -qO "/opt/wine-$WINE_BRANCH/bin/winetricks" https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
 && chmod g+w,a+x "/opt/wine-$WINE_BRANCH/bin/winetricks" \
 && chgrp adm "/opt/wine-$WINE_BRANCH/bin/winetricks"

# add to path
ENV PATH="/opt/wine-$WINE_BRANCH/bin:$PATH"

# set the default wine arch
ENV WINEARCH=win64

# add dotnet
RUN export WINEPREFIX=/usr/local/share/wine \
 && export WINEDLLOVERRIDES="mscoree,mshtml=" \
 && mkdir -p "$WINEPREFIX" \
 && winetricks -q d3dcompiler_43 dotnet472 \
 && rm -rf /root/.cache/winetricks

# add corefonts and multimedia packages
RUN export WINEPREFIX=/usr/local/share/wine \
 && export WINEDLLOVERRIDES="mscoree,mshtml=" \
 && mkdir -p "$WINEPREFIX" \
 && winetricks -q \
      corefonts \
      d9vk_master \
      sdl \
      vulkanrt \
      xinput \
 && rm -rf /root/.cache/winetricks

ENV WINEPREFIX=/data

# create directories
RUN \
 for d in "$WINEPREFIX"; do \
   mkdir -p "$d"; \
   chown ubuntu:ubuntu "$d"; \
   chmod 2750 "$d"; \
 done

# copy files to container
COPY wine-bootstrap /usr/local/bin/wine-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link directories
RUN ln -s "$WINEPREFIX" /home/ubuntu/.wine

# export volumes
VOLUME $WINEPREFIX

# set directories to be chowned on container start
ENV USER_DIRS ${WINEPREFIX}${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/wine-bootstrap

################################################################################
# labels
################################################################################

ARG LABEL_NAME
ARG LABEL_VERSION=$WINE_BRANCH
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
