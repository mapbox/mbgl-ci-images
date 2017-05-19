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
 && apt-get -y install git make curl zip unzip nodejs python python-pip gcc-6 g++-6 closure-compiler locales\
 && rm -rf /var/lib/apt/lists/*

RUN set -eu \
 && pip install awscli

# --------------------------------------------------------------------------------------------------
# install code

WORKDIR /src

RUN set -eu \
 && git clone https://github.com/mapbox/mapbox-gl-rtl-text.git . \
 && npm install --ignore-scripts

# --------------------------------------------------------------------------------------------------
# Set environment variables

ENV CC="gcc-6" \
    CXX="g++-6"
