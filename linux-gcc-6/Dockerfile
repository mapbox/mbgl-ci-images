ARG REV=latest
FROM mbgl/ci:${REV}-linux

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y install gcc-6 g++-6 \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Set environment variables

ENV CC="gcc-6" \
    CXX="g++-6"
