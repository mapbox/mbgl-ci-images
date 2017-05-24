FROM mbgl/ci:latest-linux-gcc-5

# --------------------------------------------------------------------------------------------------
# Set environment variables

RUN set -eu \
 && apt-get update \
 && apt-get -y install libjemalloc-dev qt4-default libqt4-sql-mysql \
 && rm -rf /var/lib/apt/lists/*
