FROM mbgl/ci:latest-linux

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y install gcc-7 g++-7 \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Set environment variables

ENV CC="gcc-7" \
    CXX="g++-7"
