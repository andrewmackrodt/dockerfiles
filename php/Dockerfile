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
ARG PHP_VERSION

# add ondrej/php repository
RUN apt-get update -qq \
 && apt-get install -qqy \
      software-properties-common \
 && add-apt-repository -y ppa:ondrej/php \
 && apt-get purge -qqy --auto-remove \
      software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install php packages
RUN apt-get update -qq \
 && apt-get install -qqy \
      php${PHP_VERSION}-bcmath \
      php${PHP_VERSION}-bz2 \
      php${PHP_VERSION}-cli \
      php${PHP_VERSION}-common \
      php${PHP_VERSION}-curl \
      php${PHP_VERSION}-dev \
      php${PHP_VERSION}-gd \
      php${PHP_VERSION}-gmp \
      php${PHP_VERSION}-igbinary \
      php${PHP_VERSION}-imap \
      php${PHP_VERSION}-intl \
      php${PHP_VERSION}-json \
      php${PHP_VERSION}-mbstring \
      php${PHP_VERSION}-memcached \
      php${PHP_VERSION}-mysql \
      php${PHP_VERSION}-opcache \
      php${PHP_VERSION}-pgsql \
      php${PHP_VERSION}-readline \
      php${PHP_VERSION}-redis \
      php${PHP_VERSION}-soap \
      php${PHP_VERSION}-sqlite3 \
      php${PHP_VERSION}-xml \
      php${PHP_VERSION}-xsl \
      php${PHP_VERSION}-zip \
      php-xdebug \
 && rm -rf /var/lib/apt/lists/*

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && mv composer.phar /usr/local/bin \
 && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer \
 && chgrp adm /usr/local/bin /usr/local/bin/composer* \
 && chmod 2775 /usr/local/bin \
 && chmod 0775 /usr/local/bin/composer*

# copy xdebug config
COPY entrypoint.d /etc/entrypoint.d
COPY xdebug.ini /etc/php/$PHP_VERSION/mods-available/xdebug.ini

# disable xdebug
RUN phpdismod xdebug

ENV ENTRYPOINT0 /usr/bin/php

USER ubuntu
WORKDIR /home/ubuntu
