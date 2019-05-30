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
ARG NODEJS_VERSION
ARG NODEJS_MAJOR_VERSION

RUN set -ex \
 && wget -qO- "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}" | bash - \
 && apt-get install -qqy --no-install-recommends \
      nodejs=$NODEJS_VERSION \
 && rm -rf /var/lib/apt/lists/*

ENV ENTRYPOINT0 /usr/bin/node

USER ubuntu
WORKDIR /home/ubuntu

RUN npm config set prefix $HOME/node_modules
RUN npm install -g yarn

ENV PATH /home/ubuntu/node_modules/bin:$PATH
