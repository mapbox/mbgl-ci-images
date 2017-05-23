FROM mbgl/ci:latest-android-ndk-r15beta2

RUN set -eu \
 && git pull \
 && make android-checkstyle \
 && git clean -fdx
