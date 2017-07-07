FROM mbgl/ci:latest-linux


# --------------------------------------------------------------------------------------------------
# Install yarn

RUN set -eu \
 && curl -o- -L https://yarnpkg.com/install.sh | bash

ENV PATH="~/.yarn/bin:$PATH"


# --------------------------------------------------------------------------------------------------
# install code

WORKDIR /src

RUN set -eu \
 && git clone https://github.com/mapbox/mapbox-gl-js.git .
