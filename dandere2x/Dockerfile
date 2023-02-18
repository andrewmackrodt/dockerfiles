FROM andrewmackrodt/buildpack-deps

################################################################################
# Stage 1 : Build binaries
################################################################################

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install build dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      beignet-opencl-icd \
      libopencv-dev \
      mesa-opencl-icd \
      nvidia-cuda-toolkit \
      ocl-icd-opencl-dev \
      opencl-headers \
 && rm -rf /var/lib/apt/lists/*

# install newer version of cmake than apt repository
ARG CMAKE_VERSION=3.14.5

RUN wget -qO cmake_install.sh "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh" \
 && sh cmake_install.sh --prefix=/usr/local --exclude-subdir \
 && rm cmake_install.sh

# make dandere2x_cpp
ARG DANDERE2X_VERSION

RUN git clone https://github.com/aka-katto/dandere2x.git \
 && cd dandere2x \
 && git checkout "$DANDERE2X_VERSION" \
 && rm -rf src/venv

RUN cd dandere2x/dandere2x_cpp \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc)

# make waifu2x-converter-cpp
ARG WAIFU2X_CONVERTER_VERSION=55d42fb

RUN git clone https://github.com/DeadSix27/waifu2x-converter-cpp.git \
 && cd waifu2x-converter-cpp \
 && git checkout "$WAIFU2X_CONVERTER_VERSION"

RUN cd waifu2x-converter-cpp \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && DESTDIR=dist make install

## make waifu2x-caffe
#ARG WAIFU2X_CAFFE_VERSION=feb6095
#
#RUN git clone --recursive https://github.com/nagadomi/waifu2x-caffe-ubuntu.git waifu2x-caffe \
# && cd waifu2x-caffe \
# && git checkout "$WAIFU2X_CAFFE_VERSION" \
# && git submodule update --init --recursive
#
#ARG CAFFE_VERSION=eeebdab
#
#RUN cd waifu2x-caffe \
# && git clone https://github.com/BVLC/caffe.git \
# && cd caffe \
# && git checkout "$CAFFE_VERSION"
#
#RUN apt-get update -qq \
# && apt-get install -qqy --no-install-recommends \
#      libatlas-base-dev \
#      libboost-all-dev \
#      libboost-python-dev \
#      libgflags-dev \
#      libgoogle-glog-dev \
#      libhdf5-dev \
#      libleveldb-dev \
#      liblmdb-dev \
#      libprotobuf-dev \
#      libsnappy-dev \
#      protobuf-compiler \
#      python-protobuf \
#      python-skimage \
# && rm -rf /var/lib/apt/lists/*
#
#RUN cd waifu2x-caffe \
# && mkdir build \
# && cd build \
# && cmake -DCUDNN_INCLUDE=/usr/lib/cuda/include .. \
# && make -j$(nproc) \
# && DESTDIR=dist make install

################################################################################
# Stage 2 : Create a new image and copy files
################################################################################

FROM andrewmackrodt/ubuntu-x11

USER root
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      beignet-opencl-icd \
      ffmpeg \
      libopencv-dev \
      mesa-opencl-icd \
      nvidia-cuda-toolkit \
      opencl-headers \
 && rm -rf /var/lib/apt/lists/*

## install caffe dependencies
#RUN apt-get update -qq \
# && apt-get install -qqy --no-install-recommends \
#      libatlas3-base \
#      libgflags2.2 \
#      libgoogle-glog0v5 \
#      libhdf5-dev \
#      libleveldb1v5 \
#      liblmdb0 \
#      libsnappy1v5 \
# && rm -rf /var/lib/apt/lists/*

# add python repository
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends software-properties-common \
 && (add-apt-repository -y ppa:jonathonf/python-3.7 || true) \
 && apt-get purge -qqy --auto-remove software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# install python
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      python3.7 \
      python3-pip \
 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 10 \
 && rm -rf /var/lib/apt/lists/*

# copy dandere2x
COPY --from=0 /root/dandere2x/src /opt/dandere2x

# copy dandere2x_cpp
COPY --from=0 /root/dandere2x/dandere2x_cpp/build/dandere2x_cpp /usr/local/bin/dandere2x_cpp

# copy waifu2x-converter-cpp
COPY --from=0 /root/waifu2x-converter-cpp/build/dist /

# link libraries
RUN ln -s /usr/local/lib/libw2xc.so /usr/lib/x86_64-linux-gnu/

# link waifu2x models_rgb
RUN ln -s /usr/local/share/waifu2x-converter-cpp /opt/dandere2x/models_rgb

## copy waifu2x-caffe
#COPY --from=0 /root/waifu2x-caffe/build/dist /

# linux fix
RUN sed -i 's/, creationflags=subprocess.CREATE_NEW_CONSOLE)/)/g' /opt/dandere2x/wrappers/*.py

# copy files to container
COPY dandere2x /opt/dandere2x
COPY dandere2x-bootstrap /usr/local/bin/dandere2x-bootstrap

# install python libraries
RUN cd /opt/dandere2x \
 && pip3 install -r requirements.txt

# create the workspace directory
RUN mkdir /workspace \
 && chown ubuntu:ubuntu /workspace

VOLUME /workspace

# set directories to be chowned on container start
ENV USER_DIRS /opt/dandere2x${USER_DIRS:+:$USER_DIRS}

# set the secondary entrypoint
ENV ENTRYPOINT0 /usr/local/bin/dandere2x-bootstrap

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
