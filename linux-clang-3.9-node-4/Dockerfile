ARG REV=latest
FROM mbgl/${REV}:linux-clang-3.9

# --------------------------------------------------------------------------------------------------
# Remove Node v6 from base image

RUN set -eu \
 && rm /etc/apt/sources.list.d/nodesource-v6.list \
 && apt-get update \
 && apt-get -y -qq purge nodejs

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y install nodejs \
 && rm -rf /var/lib/apt/lists/*
