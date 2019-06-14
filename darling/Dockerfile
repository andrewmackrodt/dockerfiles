FROM andrewmackrodt/buildpack-deps

################################################################################
# Stage 1 : Build the binary
################################################################################

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      bison \
      clang \
      cmake \
      flex \
      gcc-multilib \
      kmod \
      libbsd-dev \
      libc6-dev:i386 \
      libcairo2-dev \
      libcap2-bin \
      libegl1-mesa-dev \
      libelf-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libfreetype6-dev:i386 \
      libfuse-dev \
      libgl1-mesa-dev \
      libglvnd-dev \
      libtiff5-dev \
      libudev-dev \
      libxext-dev \
      libxml2-dev \
      linux-headers-generic \
      pkg-config \
      python-dev \
      xz-utils \
 && rm -rf /var/lib/apt/lists/*

ARG DARLING_VERSION

RUN git clone --recursive https://github.com/darlinghq/darling.git

RUN cd darling \
 && git checkout "$DARLING_VERSION"

RUN cd darling/src/external/foundation \
 && git checkout 64c8cc

RUN cd darling \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j $(expr $(nproc) / 2 + 1)

RUN cd darling/build \
 && make install

RUN cd darling/build \
 && make -j $(expr $(nproc) / 2 + 1) lkm

RUN cd darling/build \
 && make lkm

RUN cd darling/build \
 && make install lkm_install || true

################################################################################
# Stage 2 : Create a new image and copy the binary
################################################################################

FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

# install dependecies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      bison \
      clang \
      cmake \
      flex \
      gcc-multilib \
      kmod \
      libbsd-dev \
      libc6-dev:i386 \
      libcairo2-dev \
      libcap2-bin \
      libegl1-mesa-dev \
      libelf-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libfreetype6-dev:i386 \
      libfuse-dev \
      libgl1-mesa-dev \
      libglvnd-dev \
      libtiff5-dev \
      libudev-dev \
      libxext-dev \
      libxml2-dev \
      linux-headers-generic \
      pkg-config \
      python-dev \
      xz-utils \
 && rm -rf /var/lib/apt/lists/*

# copy darling
COPY --from=0 /usr/local/libexec/darling /usr/local/libexec/darling
COPY --from=0 /usr/local/bin/darling /usr/local/bin/darling
COPY --from=0 "/lib/modules/$(uname -r)/extra/darling-mach.ko" "/lib/modules/$(uname -r)/extra/darling-mach.ko"
COPY --from=0 /root/darling/build/src/lkm /root/darling/build/src/lkm

# run as root while testing
## stepdown to the ubuntu user
#USER ubuntu
#WORKDIR /home/ubuntu

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/darling

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
