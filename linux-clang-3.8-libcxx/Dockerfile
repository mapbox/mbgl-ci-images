ARG REV=latest
FROM mbgl/${REV}:linux

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y install clang-3.8 libc++-dev libc++abi-dev \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Set environment variables

ENV CC="clang-3.8" \
    CXX="clang++-3.8" \
    CXXFLAGS="-stdlib=libc++ -I/usr/include/libcxxabi"
