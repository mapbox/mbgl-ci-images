FROM ubuntu:16.04

ENV DEBIAN_FRONTEND="noninteractive"

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install git make curl zip unzip nodejs python python-pip \
 && rm -rf /var/lib/apt/lists/*

RUN set -eu \
 && pip install awscli

# --------------------------------------------------------------------------------------------------
# Setup environment

RUN locale-gen en_US.UTF-8

# libsysconfcpus.so can be used to alter the number of CPUs reported by the system
COPY libsysconfcpus.so /usr/lib/

ENV LD_PRELOAD=/usr/lib/libsysconfcpus.so \
    LC_ALL="en_US.UTF-8"

# --------------------------------------------------------------------------------------------------
# install code

WORKDIR /src

RUN set -eu \
 && git clone https://github.com/mapbox/mapbox-gl-native.git . \
 && git submodule update --init mapbox-gl-js \
 && npm install --ignore-scripts
