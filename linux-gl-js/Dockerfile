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
 && apt-get -y install git make curl zip unzip nodejs python python-pip locales \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Install yarn

RUN set -eu \
 && curl -o- -L https://yarnpkg.com/install.sh | bash

ENV PATH="~/.yarn/bin:$PATH"

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
 && git clone https://github.com/mapbox/mapbox-gl-js.git .

# --------------------------------------------------------------------------------------------------
# Install common linux packages

RUN set -eu \
 && apt-get update \
 && apt-get -y install build-essential ruby zlib1g-dev libcurl4-openssl-dev \
 && apt-get -y install xvfb libx11-dev libegl1-mesa-dev libxrandr-dev libxcursor-dev libxinerama-dev \
 && apt-get -y install lcov ccache \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/ccache:$PATH"

RUN set -eu \
 && ccache --max-size=1G
