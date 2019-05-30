FROM andrewmackrodt/ubuntu

ARG LABEL_NAME
ARG VERSION
ARG LABEL_USAGE
ARG LABEL_VENDOR
ARG LABEL_VCS_URL
ARG LABEL_VCS_REF

LABEL org.label-schema.name="$LABEL_NAME" \
  org.label-schema.version="$VERSION" \
  org.label-schema.usage="$LABEL_USAGE" \
  org.label-schema.vendor="$LABEL_VENDOR" \
  org.label-schema.vcs-url="$LABEL_VCS_URL" \
  org.label-schema.vcs-ref="$LABEL_VCS_REF" \
  org.label-schema.schema-version="1.0"

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install x11 packages
RUN dpkg --add-architecture i386 \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      dbus-x11:i386 \
      gnome-icon-theme:i386 \
      libcanberra-gtk-module:i386 \
      libcanberra-gtk3-module:i386 \
      libgl1-mesa-dri:i386 \
      libgl1-mesa-glx:i386 \
      libnvidia-gl-390:i386 \
      rtkit:i386 \
      pulseaudio:i386 \
 && rm -rf /var/lib/apt/lists/*

# add ubuntu user to multimedia
RUN for group in video audio voice pulse rtkit \
     ; do \
         adduser ubuntu $group ; \
     done

USER ubuntu
WORKDIR /home/ubuntu
