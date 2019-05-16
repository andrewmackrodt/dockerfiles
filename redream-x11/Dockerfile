FROM andrewmackrodt/ubuntu-x11:18.04

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

ARG REDREAM_VERSION

# create directories
RUN for d in /opt/redream /saves /config /bios /cache; do \
      mkdir "$d"; \
      chown ubuntu:adm "$d"; \
      chmod 2770 "$d"; \
    done

# install redream to /opt/redream
RUN wget -qO- "https://redream.io/download/redream.x86_64-linux-v$REDREAM_VERSION.tar.gz" > redream.tar.gz \
 && tar zxf redream.tar.gz -C /opt/redream \
 && rm -f redream.tar.gz \
 && chown -R ubuntu:adm /opt/redream \
 && chmod -R g+w /opt/redream

# create a symlink to redream bin
RUN ln -s /opt/redream/redream /usr/local/bin/redream

# link cache directory
RUN ln -s /cache /opt/redream/cache

# copy files to container
COPY redream-bootstrap /usr/local/bin/redream-bootstrap

ENV ENTRYPOINT0 /usr/local/bin/redream-bootstrap

USER ubuntu
WORKDIR /home/ubuntu
