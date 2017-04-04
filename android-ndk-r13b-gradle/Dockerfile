FROM mbgl/ci:latest-android-ndk-r13b

RUN set -eu \
 && make android-checkstyle \
 && git clean -fdx
