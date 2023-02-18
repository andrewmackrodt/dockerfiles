FROM andrewmackrodt/ubuntu

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION
ARG PYTHON_MINOR_VERSION
ARG PYTHON_MAJOR_VERSION

# install python packages
RUN apt-get update -qq \
 && apt-get install -qqy \
      python${PYTHON_MINOR_VERSION}=${PYTHON_VERSION} \
      python${PYTHON_MINOR_VERSION}-dev \
      $( \
          if [ "${PYTHON_MAJOR_VERSION}" -gt "2" ]; then \
            echo python${PYTHON_MAJOR_VERSION}-pip ; \
          fi \
        ) \
      git \
 && rm -rf /var/lib/apt/lists/*

# manually install pip if python2
RUN if [ "${PYTHON_MAJOR_VERSION}" = "2" ]; then \
      wget -qO- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python${PYTHON_MINOR_VERSION} ; \
    fi

# set PYTHON_MAJOR_VERSION as default
RUN update-alternatives --install /usr/bin/python${PYTHON_MAJOR_VERSION} python${PYTHON_MAJOR_VERSION} /usr/bin/python${PYTHON_MINOR_VERSION} 10 \
 && update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_MAJOR_VERSION} 10 \
 && if [ "${PYTHON_MAJOR_VERSION}" -gt "2" ]; then \
      update-alternatives --install /usr/bin/pip pip /usr/bin/pip${PYTHON_MAJOR_VERSION} 10 ; \
    fi

ENV ENTRYPOINT0 /usr/bin/python

USER ubuntu
WORKDIR /home/ubuntu

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
