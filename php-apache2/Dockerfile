FROM andrewmackrodt/php:8.4

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

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION

# add ondrej/apache2 repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:ondrej/apache2 || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install apache packages
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      apache2 \
      apache2-utils \
      libapache2-mod-php$PHP_VERSION \
      python3-certbot-apache \
 && phpdismod xdebug \
 && rm -rf /var/lib/apt/lists/*

# enable modules
RUN a2enmod rewrite \
 && a2enmod headers \
 && a2enmod ssl

RUN { \
      echo '# trust proxies from IANA private internets' ; \
      echo '<IfModule mod_remoteip.c>' ; \
      echo '    RemoteIPHeader X-Forwarded-For' ; \
      echo '    RemoteIPTrustedProxy 10.0.0.0/8' ; \
      echo '    RemoteIPTrustedProxy 172.16.0.0/12' ; \
      echo '    RemoteIPTrustedProxy 192.168.0.0/16' ; \
      echo '</IfModule>' ; \
      echo '' ; \
    } \
      > /etc/apache2/mods-available/remoteip.conf \
 && a2enmod remoteip

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
COPY cont-init.d /etc/cont-init.d
COPY services.d /etc/services.d
COPY entrypoint.d /etc/entrypoint.d

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# unset ENTRYPOINT0, we want s6-overlay to run the apache daemon
ENV ENTRYPOINT0=''

# start services unless CMD is non empty
ENV S6_ENABLE 2

# expose ports
EXPOSE 80
EXPOSE 443

# export volumes
VOLUME /etc/letsencrypt/live
