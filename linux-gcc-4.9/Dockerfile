ARG REV=latest
FROM mbgl/${REV}:linux

# --------------------------------------------------------------------------------------------------
# Install common packages

RUN set -eu \
 && apt-get update \
 && apt-get -y install gcc-4.9 g++-4.9 \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Set environment variables

ENV CC="gcc-4.9" \
    CXX="g++-4.9"
