FROM andrewmackrodt/ubuntu

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add google cloud gpg key
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends gnupg \
 && wget -qO- https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && apt-get purge -qqy --auto-remove gnupg \
 && rm -rf /var/lib/apt/lists/* /root/.gnupg

ARG GOOGLE_CLOUD_SDK_VERSION

# install google-cloud-sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends google-cloud-sdk=$GOOGLE_CLOUD_SDK_VERSION \
 && rm -rf /var/lib/apt/lists/*

# create /config
RUN mkdir /config \
 && chgrp adm /config \
 && chmod 2770 /config

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link /config
RUN mkdir -p /home/ubuntu/.config \
 && ln -s /config /home/ubuntu/.config/gcloud

# export volumes
VOLUME /config

# set directories to be chowned on container start
ENV USER_DIRS /config${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/bin/gcloud

################################################################################
# labels
################################################################################

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
