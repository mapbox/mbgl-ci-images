ARG REV=latest
FROM mbgl/${REV}:linux-gcc-5

# --------------------------------------------------------------------------------------------------
# Install protobuf and pkg-config

# Add the `ppa:maarten-fonville/protobuf` repository first, which contains newer version of
# the `protobuf` packages.
RUN set -eu \
 && apt-get update \
 && apt-get -y install software-properties-common \
 && add-apt-repository -y ppa:maarten-fonville/protobuf \
 && apt-get update \
 && apt-get -y install protobuf-compiler libprotobuf-dev pkg-config \
 && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------------------------------------
# Install Qt

# Use most recent version from http://download.qt.io/archive/qt/ and update the checksum.
# Don't forget to update the version number in the installation script.
COPY *.qs /src
RUN set -eu \
 && curl -L --retry 3 http://download.qt.io/official_releases/qt/5.9/5.9.3/qt-opensource-linux-x64-5.9.3.run -o qt.run \
 && (echo "4df4f8e6ccd61f9aa038ad4a6e688412a95de78f8607c4132b8277f05aac24b8  qt.run" | sha256sum -c) \
 && chmod +x qt.run \
 && xvfb-run --server-args="-screen 0 1024x768x24" ./qt.run --platform=minimal --script install.qs \
 && mkdir -p /opt/qt \
 && rm -rf qt.run install.qs /opt/qt/Examples /opt/qt/Tools

ENV PATH="/opt/qt/5.9.3/gcc_64/bin:$PATH"
