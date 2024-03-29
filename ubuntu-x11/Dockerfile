FROM andrewmackrodt/ubuntu

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

# install x11 packages
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      dbus-x11 \
      gnome-icon-theme \
      libcanberra-gtk-module \
      libcanberra-gtk3-module \
      libgl1-mesa-dri \
      libgl1-mesa-glx \
      libnotify-bin \
      rtkit \
      pulseaudio \
 && rm -rf /var/lib/apt/lists/*

# install nvidia driver from proprietary gpu drivers repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:graphics-drivers/ppa || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && apt-get install -qqy --no-install-recommends libnvidia-gl-525 \
 && rm -rf /var/lib/apt/lists/*

# copy files to the container
COPY entrypoint.d /etc/entrypoint.d

# add ubuntu user to multimedia
RUN for group in video audio voice pulse rtkit \
     ; do \
         adduser ubuntu $group ; \
     done

USER ubuntu
WORKDIR /home/ubuntu
