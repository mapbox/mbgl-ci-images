FROM mbgl/ci:latest-linux-gcc-5

# --------------------------------------------------------------------------------------------------
# Set environment variables

WORKDIR /opt

RUN set -eu \
 && sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list \
 && apt-get update \
 && apt-get build-dep -y qt5-default \
 && apt-get install -y libc6-dbg libxinerama-dev libxcb-xinerama0-dev \
 && rm -rf /var/lib/apt/lists/*

RUN set -eu \
 && git clone git://code.qt.io/qt/qt5.git

WORKDIR /opt/qt5

RUN set -eu \
 && git checkout 5.9

RUN set -eu \
 && ./init-repository --branch \
    --module-subset=qtbase,qtxmlpatterns,qtdeclarative,qtgraphicaleffects,qtquickcontrols,qtsvg,qtimageformats,qtlocation,qtserialport,qttools

WORKDIR /opt/qt5/build

RUN set -eu \
 && mkdir -p /opt/qt-5.9 \
 && ../configure \
    -opensource -confirm-license \
    -nomake tests -nomake examples \
    -release -prefix /opt/qt-5.9 \
    -qt-zlib

RUN set -eu \
 && make -j4 \
 && make install

ENV PATH="/opt/qt-5.9/bin:$PATH"

WORKDIR /opt

RUN set -eu \
 && rm -rf qt5 \
 && ccache --clear

WORKDIR /src
