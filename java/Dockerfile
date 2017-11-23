ARG REV=latest
FROM mbgl/ci:${REV}-base

# --------------------------------------------------------------------------------------------------
# Install system packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN find /tmp/*.gpg | xargs -n1 apt-key add

RUN dpkg --add-architecture i386

RUN set -eu \
 && apt-get update \
 && apt-get -y install openjdk-8-jdk-headless google-cloud-sdk \
        libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
 && rm -rf /var/lib/apt/lists/*
