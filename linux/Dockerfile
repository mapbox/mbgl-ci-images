ARG REV=latest
FROM mbgl/${REV}:base

# --------------------------------------------------------------------------------------------------
# Install common packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN set -eu \
 && (find /tmp/*.gpg | xargs -n1 apt-key add) \
 && rm /tmp/*.gpg

RUN set -eu \
 && apt-get update \
 && apt-get -y install cmake build-essential gdb file ruby zlib1g-dev libcurl4-openssl-dev xvfb \
                       libx11-dev libegl1-mesa-dev libgles2-mesa-dev libgl1-mesa-dev libxrandr-dev \
                       libxcursor-dev libxinerama-dev libxi-dev dbus lcov \
 && rm -rf /var/lib/apt/lists/*

# Install coveralls
RUN set -eu \
 && gem install coveralls-lcov --no-rdoc --no-ri

# Download logbt
RUN set -eu \
 && curl -L --retry 3 https://raw.githubusercontent.com/mapbox/logbt/v2.0.2/bin/logbt -o /usr/bin/logbt \
 && chmod +x /usr/bin/logbt \
 && logbt --version

# Compile and install apitrace
RUN set -eu \
 && git clone --depth=1 https://github.com/apitrace/apitrace.git \
 && cd apitrace \
 && cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release -DENABLE_GUI=FALSE \
 && make -C build install -j8 \
 && cd .. \
 && rm -rf apitrace \
 && ccache --clear
