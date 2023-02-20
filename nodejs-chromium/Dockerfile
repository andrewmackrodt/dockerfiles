FROM andrewmackrodt/nodejs:lts

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# add phd/chromium-browser repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:phd/chromium-browser || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      $( \
          apt-cache show chromium-browser \
            | sed -nE 's/^Depends: //p' \
            | tr ',' $'\n' \
            | awk '{ print $1 }' \
            | grep . \
            | sort \
            | uniq \
        ) \
 && rm -rf /var/lib/apt/lists/*

ARG LABEL_VERSION

# install chromium-browser
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends chromium-browser \
 && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium-browser
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

USER ubuntu
WORKDIR /home/ubuntu

################################################################################
# labels
################################################################################

ARG LABEL_NAME
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
