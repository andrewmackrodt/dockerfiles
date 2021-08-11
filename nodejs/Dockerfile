FROM andrewmackrodt/buildpack-deps

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive
ARG NODEJS_VERSION
ARG NODEJS_MAJOR_VERSION

# install nodejs packages
RUN wget -qO- "https://deb.nodesource.com/setup_${NODEJS_MAJOR_VERSION}" | bash - \
 && apt-get install -qqy --no-install-recommends \
      nodejs=$NODEJS_VERSION \
 && rm -rf /var/lib/apt/lists/*

# install python packages
RUN apt-get update -qq \
 && apt-get install -qqy \
      python3 \
      python3-dev \
      python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
 && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 ;

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
