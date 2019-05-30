FROM andrewmackrodt/buildpack-deps

ARG LABEL_NAME
ARG VERSION
ARG LABEL_USAGE
ARG LABEL_VENDOR
ARG LABEL_VCS_URL
ARG LABEL_VCS_REF

LABEL org.label-schema.name="$LABEL_NAME" \
  org.label-schema.version="$VERSION" \
  org.label-schema.usage="$LABEL_USAGE" \
  org.label-schema.vendor="$LABEL_VENDOR" \
  org.label-schema.vcs-url="$LABEL_VCS_URL" \
  org.label-schema.vcs-ref="$LABEL_VCS_REF" \
  org.label-schema.schema-version="1.0"

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add docker-ce gpg key
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends gnupg \
 && mkdir /root/.gnupg \
 && echo 'disable-ipv6' >> /root/.gnupg/dirmngr.conf \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8 \
 && apt-get purge -qqy --auto-remove gnupg \
 && rm -rf /var/lib/apt/lists/* /root/.gnupg

ARG DOCKER_VERSION

# install docker-ce
RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) stable" > /etc/apt/sources.list.d/docker.list \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends docker-ce=$DOCKER_VERSION \
 && rm -rf /var/lib/apt/lists/*

RUN adduser ubuntu docker

ENV ENTRYPOINT0 /usr/bin/docker

USER ubuntu
WORKDIR /home/ubuntu
