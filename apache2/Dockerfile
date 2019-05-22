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

# enable modules
RUN a2enmod rewrite \
 && a2enmod headers \
 && a2enmod ssl

# configure /var/www
RUN perl -0777 -i \
  -pe 's#(<Directory /var/www/?>[^<]+AllowOverride)[ \t]+None#\1 All#;' \
  -pe 's#(<Directory /var/www/?>[^<]+Options[^\n]*)\bIndexes\b#\1#;' \
  /etc/apache2/apache2.conf

# pipe logs to stdout/stderr
RUN sed -ri \
  -e 's#(^[ \t]*(Custom|Transfer)Log)[ \t]+[^ \t]+#\1 /proc/self/fd/1#' \
  -e 's#(^[ \t]*ErrorLog)[ \t]+[^ \t]+#\1 /proc/self/fd/2#' \
  /etc/apache2/conf-available/other-vhosts-access-log.conf \
  /etc/apache2/sites-available/000-default.conf \
  /etc/apache2/sites-available/default-ssl.conf \
  /etc/apache2/apache2.conf

# copy files to container
COPY services.d /etc/services.d

EXPOSE 80
EXPOSE 443

ENV S6_ENABLE 2

USER ubuntu
WORKDIR /home/ubuntu
