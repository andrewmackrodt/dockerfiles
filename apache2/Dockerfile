FROM andrewmackrodt/ubuntu:18.04

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
ARG APACHE_VERSION

# add ondrej/apache2 repository
RUN apt-get update -qq \
 && apt-get install -qqy \
      software-properties-common \
 && add-apt-repository -y ppa:ondrej/apache2 \
 && apt-get purge -qqy --auto-remove \
      software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install apache packages
RUN apt-get update -qq \
 && apt-get install -qqy \
      apache2 \
      apache2-utils \
 && rm -rf /var/lib/apt/lists/*

# copy files to container
COPY services.d /etc/services.d

ENV S6_ENABLE 2

USER ubuntu
WORKDIR /home/ubuntu
