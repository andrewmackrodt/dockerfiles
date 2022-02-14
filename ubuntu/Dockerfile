FROM ubuntu:20.04

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

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      ca-certificates \
      sudo \
      tzdata \
      wget \
 && rm -rf /var/lib/apt/lists/*

# add tini
RUN ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -q -O /tmp/release.json "https://api.github.com/repos/krallin/tini/releases/latest" \
 && grep -E '"browser_download_url":.+'$ARCH'' /tmp/release.json | grep -v -E ".(asc|sig)" | head -n1 | cut -d '"' -f4 > /tmp/release.txt \
 && wget -q -O /usr/local/bin/tini "$(cat /tmp/release.txt)" \
 && chmod +x /usr/local/bin/tini \
 && rm -f /tmp/release.*

# add gosu
RUN ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -q -O /tmp/release.json "https://api.github.com/repos/tianon/gosu/releases/latest" \
 && grep -E '"browser_download_url":.+'$ARCH'' /tmp/release.json | grep -v -E ".(asc|sig)" | head -n1 | cut -d '"' -f4 > /tmp/release.txt \
 && wget -q -O /usr/local/bin/gosu "$(cat /tmp/release.txt)" \
 && chmod +x /usr/local/bin/gosu \
 && rm -f /tmp/release.* \
 && gosu nobody true

# add s6-overlay
RUN ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -q -O /tmp/release.json "https://api.github.com/repos/just-containers/s6-overlay/releases/38080409" \
 && grep -E '"browser_download_url":.+'$ARCH'\.tar\.gz' /tmp/release.json | grep -v -E ".(asc|sig)" | head -n1 | cut -d '"' -f4 > /tmp/release.txt \
 && wget -q -O s6-overlay.tar.gz "$(cat /tmp/release.txt)" \
 && tar zxfh s6-overlay.tar.gz -C / \
 && rm -f /tmp/release.* s6-overlay.tar.gz

# allow passwordless sudo to entrypoint
RUN /bin/echo -e "\
\n\
# Allow members of adm to execute the entrypoint\n\
%adm ALL=(ALL) NOPASSWD:SETENV: /usr/local/bin/docker-entrypoint.sh\n\
" \
  >/etc/sudoers.d/passwordless

# copy files to the container
COPY entrypoint.d /etc/entrypoint.d
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# create the ubuntu user
RUN addgroup --gid 1000 ubuntu \
 && adduser --gecos "" \
      --shell /bin/bash \
      --uid 1000 \
      --gid 1000 \
      --disabled-password \
      ubuntu \
 && adduser ubuntu adm

# make /var/log writeable by adm group
RUN chgrp -R adm /var/log \
 && chmod -R g+w /var/log \
 && find /var/log -type d -exec chmod g+s {} \;

# change to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# create common directories, some apps will fail if they don't exist
RUN mkdir -p \
  /home/ubuntu/.cache \
  /home/ubuntu/.config \
  /home/ubuntu/.local/share

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
