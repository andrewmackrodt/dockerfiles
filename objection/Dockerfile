FROM andrewmackrodt/python:3.9

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install objection dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      aapt \
      adb \
      apksigner \
      zipalign \
 && rm -rf /var/lib/apt/lists/*

# add apktool
RUN wget -qO /usr/local/bin/apktool.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.7.0.jar \
 && wget -qO /usr/local/bin/apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool \
 && chmod +x /usr/local/bin/apktool

# install objection
ARG OBJECTION_VERSION
RUN pip install --no-cache-dir "objection==$OBJECTION_VERSION"

USER ubuntu
WORKDIR /home/ubuntu

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/objection

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
