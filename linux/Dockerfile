FROM mbgl/ci:latest-base

# --------------------------------------------------------------------------------------------------
# Install common packages

RUN set -eu \
 && apt-get update \
 && apt-get -y install cmake build-essential file ruby zlib1g-dev libcurl4-openssl-dev \
 && apt-get -y install xvfb libx11-dev libegl1-mesa-dev libxrandr-dev libxcursor-dev libxinerama-dev \
 && apt-get -y install lcov ccache \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/ccache:$PATH"

RUN set -eu \
 && ccache --max-size=1G

RUN set -eu \
 && gem install coveralls-lcov --no-rdoc --no-ri
