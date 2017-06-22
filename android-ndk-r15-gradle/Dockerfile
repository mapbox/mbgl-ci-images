FROM mbgl/ci:r3-android-ndk-r15

RUN set -eu \
 && git pull \
 && make android-checkstyle \
 && git clean -fdx
