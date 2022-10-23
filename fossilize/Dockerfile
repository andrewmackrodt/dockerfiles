FROM andrewmackrodt/buildpack-deps

################################################################################
# Stage 1 : Build binaries
################################################################################

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends cmake \
 && rm -rf /var/lib/apt/lists/*

ARG FOSSILIZE_VERSION

RUN git clone --recurse-submodules https://github.com/ValveSoftware/Fossilize.git \
 && cd Fossilize \
 && git checkout "$FOSSILIZE_VERSION"

RUN cd Fossilize \
 && mkdir build \
 && cd build \
 && cmake .. \
 && cmake --build .

RUN mkdir build \
 && find Fossilize/build/cli -mindepth 1 -maxdepth 1 -type f -executable -name 'fossilize-*' -exec mv {} build/ \;

################################################################################
# Stage 2 : Create a new image and copy binaries
################################################################################

FROM andrewmackrodt/ubuntu

USER root
WORKDIR /root

# copy binaries
COPY --from=0 /root/build /usr/local/bin

# stepdown to the ubuntu user
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
