FROM andrewmackrodt/buildpack-deps

################################################################################
# Stage 1 : Build the binary
################################################################################

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      cmake \
      libgl1-mesa-dev \
      libglew-dev \
      libglfw3-dev \
      linux-libc-dev \
      qtmultimedia5-dev \
      libqt5opengl5-dev \
      libsdl2-dev \
      qtbase5-dev \
 && rm -rf /var/lib/apt/lists/*

ARG YABAUSE_VERSION

RUN git clone https://github.com/devmiyax/yabause.git \
 && cd yabause \
 && git checkout "$YABAUSE_VERSION"

RUN cd yabause \
 && sed -i -E 's/if ?\( ?! ?ANDROID\)/if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")/' yabause/src/CMakeLists.txt \
 && mkdir build \
 && cd build \
 && cmake ../yabause \
 && make

################################################################################
# Stage 2 : Create a new image and copy the binary
################################################################################

FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

# install dependecies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      libglew2.0 \
      libsdl2.2 \
      libqt5dbus5 \
      libqt5multimedia5 \
      libqt5opengl5 \
 && rm -rf /var/lib/apt/lists/*

# copy the binary
COPY --from=0 /root/yabause/build/src/qt/yabause /opt/yabause/yabause

# create directories
RUN for d in /opt/yabause /saves /config; do \
      mkdir "$d"; \
      chgrp adm "$d"; \
      chmod 2775 "$d"; \
    done

# create a symlink to yabause bin
RUN ln -s /opt/yabause/yabause /usr/local/bin/yabause

# copy files to container
COPY yabause-bootstrap /usr/local/bin/yabause-bootstrap

# stepdown to the ubuntu user
USER ubuntu
WORKDIR /home/ubuntu

# link config
RUN mkdir -p /home/ubuntu/.config/yabause \
 && ln -s /config /home/ubuntu/.config/yabause/qt

# export volumes
VOLUME /config
VOLUME /saves

# set directories to be chowned on container start
ENV USER_DIRS /config:/saves${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/yabause-bootstrap

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
