FROM andrewmackrodt/buildpack-deps:18.04

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

RUN set -ex \
 && wget -q -O- https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get install -qqy \
      nodejs=10.15.3-1nodesource1 \
 && rm -rf /var/lib/apt/lists/*

ENV ENTRYPOINT0 /usr/bin/node

USER ubuntu
WORKDIR /home/ubuntu

RUN npm config set prefix $HOME/node_modules

RUN npm install -g yarn
