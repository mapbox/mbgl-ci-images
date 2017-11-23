ARG REV=latest
FROM mbgl/${REV}:linux-gcc-5

# --------------------------------------------------------------------------------------------------
# Install Qt

# Use most recent version from http://download.qt.io/archive/qt/ and update the checksum.
# Don't forget to update the version number in the installation script.
COPY *.qs /src
RUN set -eu \
 && curl -s -S -L --retry 3 http://download.qt.io/official_releases/qt/5.9/5.9.2/qt-opensource-linux-x64-5.9.2.run -o qt.run \
 && (echo "e0b2b2e6ad38fa7b5182d48ba617075e064ad06547394fa06aeddbae4850ef10  qt.run" | sha256sum -c) \
 && chmod +x qt.run \
 && xvfb-run --server-args="-screen 0 1024x768x24" ./qt.run --platform=minimal --script install.qs \
 && mkdir -p /opt/qt \
 && rm -rf qt.run install.qs /opt/qt/Examples /opt/qt/Tools

ENV PATH="/opt/qt/5.9.2/gcc_64/bin:$PATH"
