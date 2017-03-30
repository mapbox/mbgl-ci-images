FROM ubuntu:16.04

RUN set -eu \
 && apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install git build-essential

RUN set -eu \
 && mkdir -p /libsysconf \
 && cd /libsysconf \
 && git clone https://github.com/obmarg/libsysconfcpus.git . \
 && CFLAGS=-O3 ./configure --prefix=`pwd`/install \
 && make \
 && make install
