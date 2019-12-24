################################################################################
# Stage 1 : Download pretrained models
################################################################################

FROM andrewmackrodt/python:3.7

# download training models
RUN pip install gdown
RUN "$HOME/.local/bin/gdown" https://drive.google.com/uc?id=1pJ_T-V1dpb1ewoEra1TGSWl5e6H7M4NN
RUN "$HOME/.local/bin/gdown" https://drive.google.com/uc?id=1TPrz5QKd8DHHt1k8SRtm6tMiPjz_Qene

################################################################################
# Stage 2 : Prepare the ESRGAN image
################################################################################

FROM andrewmackrodt/python:3.7

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install opencv dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      libsm6 \
      libxrender1 \
 && rm -rf /var/lib/apt/lists/*

# install ESRGAN dependencies
RUN pip install \
      torch==1.2.0+cpu \
      torchvision==0.4.0+cpu \
      -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install opencv-python

USER ubuntu
WORKDIR /home/ubuntu

# clone the repository
ARG ESRGAN_VERSION

RUN git clone https://github.com/xinntao/ESRGAN \
 && cd ESRGAN \
 && git checkout "$ESRGAN_VERSION"

# copy pretrained model RRDB_PSNR_x4.pth
COPY --from=0 /home/ubuntu/RRDB_PSNR_x4.pth /home/ubuntu/ESRGAN/models/

# copy pretrained model RRDB_ESRGAN_x4.pth
COPY --from=0 /home/ubuntu/RRDB_ESRGAN_x4.pth /home/ubuntu/ESRGAN/models/

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
