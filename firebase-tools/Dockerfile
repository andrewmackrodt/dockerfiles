FROM andrewmackrodt/nodejs:lts

USER root

# create /config
RUN mkdir /config \
 && chgrp adm /config \
 && chmod 2770 /config

# continue as the ubuntu user
USER ubuntu

# link /config
RUN rm -rf /home/ubuntu/.config/configstore \
 && ln -s /config /home/ubuntu/.config/configstore

ARG FIREBASE_TOOLS_VERSION

# install firebase-tools
RUN npm install --cache /tmp/npm -g "firebase-tools@$FIREBASE_TOOLS_VERSION"

# expose ports
EXPOSE 9005

# export volumes
VOLUME /config

# set directories to be chowned on container start
ENV USER_DIRS /config${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /home/ubuntu/.local/lib/node_modules/bin/firebase

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
