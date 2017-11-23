FROM ubuntu:xenial-20171006

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
 && apt-get -y install git make curl zip unzip nodejs ccache python locales \
 && rm -rf /var/lib/apt/lists/*

# Install PIP
RUN set -eu \
 && (curl https://bootstrap.pypa.io/get-pip.py | python) \
 && pip install awscli

# Install Yarn
RUN set -eu \
 && (curl -o- -L https://yarnpkg.com/install.sh | bash)

# --------------------------------------------------------------------------------------------------
# Setup environment

RUN locale-gen en_US.UTF-8

# libsysconfcpus.so can be used to alter the number of CPUs reported by the system
COPY libsysconfcpus.so /usr/lib/

ENV LD_PRELOAD=/usr/lib/libsysconfcpus.so \
    LC_ALL="en_US.UTF-8" \
    PATH="/usr/lib/ccache:~/.yarn/bin:$PATH"

RUN set -eu \
 && ccache --max-size=1G

# --------------------------------------------------------------------------------------------------

WORKDIR /src
