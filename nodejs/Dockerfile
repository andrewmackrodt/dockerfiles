FROM andrewmackrodt/buildpack-deps

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install python packages
RUN apt-get update -qq \
 && apt-get install -qqy \
      python3 \
      python3-dev \
      python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
 && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10

# add nodesource gpg key
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends gnupg \
 && wget -qO- https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | apt-key --keyring /usr/share/keyrings/nodesource-repo.gpg add - \
 && apt-get purge -qqy --auto-remove gnupg \
 && rm -rf /var/lib/apt/lists/* /root/.gnupg

# install nodejs
ARG NODEJS_MAJOR_VERSION
ARG NODEJS_VERSION

RUN echo "deb [signed-by=/usr/share/keyrings/nodesource-repo.gpg] https://deb.nodesource.com/node_$NODEJS_MAJOR_VERSION.x nodistro main" >/etc/apt/sources.list.d/nodesource.list \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends nodejs=$NODEJS_VERSION \
 && rm -rf /var/lib/apt/lists/*

ENV ENTRYPOINT0 /usr/bin/node

USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir -p $HOME/.local/lib \
 && npm config set prefix $HOME/.local

RUN npm install -g yarn

ENV PATH /home/ubuntu/.local/bin:$PATH

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
