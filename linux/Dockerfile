FROM mbgl/ci:latest-base

# --------------------------------------------------------------------------------------------------
# Install common packages

RUN set -eu \
 && apt-get update \
 && apt-get -y install cmake build-essential file python python-pip ruby zlib1g-dev libcurl4-openssl-dev \
 && apt-get -y install xvfb libx11-dev libegl1-mesa-dev libxrandr-dev libxcursor-dev libxinerama-dev \
 && rm -rf /var/lib/apt/lists/*

RUN set -eu \
 && pip install awscli \
 && gem install coveralls-lcov --no-rdoc --no-ri
