FROM mbgl/ci:latest-android-ndk-r15beta1

RUN set -eu \
 && make android-checkstyle \
 && git clean -fdx
