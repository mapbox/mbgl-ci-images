FROM mbgl/ci:latest-android-ndk-r15

RUN set -eu \
 && apt-get update \
 && apt-get -y install ccache \
 && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/ccache:$PATH"

RUN set -eu \
 && ccache --max-size=1G

RUN set -eu \
 && git clone --depth=1 https://github.com/mapbox/mapbox-gl-native.git \
 && cd mapbox-gl-native \
 && make android-checkstyle \
 && cd .. \
 && rm -rf mapbox-gl-native
