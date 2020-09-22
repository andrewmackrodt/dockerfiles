################################################################################
# Stage 1 : Build
################################################################################

FROM andrewmackrodt/nodejs-chromium AS build

# install spotify-ripper
ARG NVIDIA_SNATCHER_VERSION

RUN git clone https://github.com/andrewmackrodt/nvidia-snatcher \
 && cd nvidia-snatcher \
 && git checkout "$NVIDIA_SNATCHER_VERSION"

WORKDIR /home/ubuntu/nvidia-snatcher

RUN npm ci

RUN npm run build

################################################################################
# Stage 2 : Package
################################################################################

FROM andrewmackrodt/nodejs-chromium

COPY --from=build --chown=ubuntu:ubuntu /home/ubuntu/nvidia-snatcher/build/ /home/ubuntu/nvidia-snatcher/
COPY --from=build --chown=ubuntu:ubuntu /home/ubuntu/nvidia-snatcher/package.json /home/ubuntu/nvidia-snatcher/package.json
COPY --from=build --chown=ubuntu:ubuntu /home/ubuntu/nvidia-snatcher/package-lock.json /home/ubuntu/nvidia-snatcher/package-lock.json

# todo remove when repository dependencies are fixed
COPY --from=build --chown=ubuntu:ubuntu /home/ubuntu/nvidia-snatcher/node_modules/ /home/ubuntu/nvidia-snatcher/node_modules/

WORKDIR /home/ubuntu/nvidia-snatcher

# todo restore when repository dependencies are fixed
#RUN npm ci --only=production

CMD ["--", "index.js"]

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
