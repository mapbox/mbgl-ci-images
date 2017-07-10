#!/usr/bin/env bash

# set REVISION=1 to build a new revision and push it to Docker Hub

set -euo pipefail

# Base images
docker build -t mbgl/ci:latest-base --squash base
docker build -t mbgl/ci:latest-linux --squash linux
docker build -t mbgl/ci:latest-java --squash java

# Final images
docker build -t mbgl/ci:r${REVISION}-linux-gl-js -t mbgl/ci:latest-linux-gl-js --squash linux-gl-js
docker push mbgl/ci:r${REVISION}-linux-gl-js

docker build -t mbgl/ci:r${REVISION}-linux-clang-3.9 -t mbgl/ci:latest-linux-clang-3.9 --squash linux-clang-3.9
docker push mbgl/ci:r${REVISION}-linux-clang-3.9

docker build -t mbgl/ci:r${REVISION}-linux-clang-3.9-node-4 --squash linux-clang-3.9-node-4
docker push mbgl/ci:r${REVISION}-linux-clang-3.9-node-4

docker build -t mbgl/ci:r${REVISION}-linux-clang-4 --squash linux-clang-4
docker push mbgl/ci:r${REVISION}-linux-clang-4

docker build -t mbgl/ci:r${REVISION}-linux-gcc-4.9 --squash linux-gcc-4.9
docker push mbgl/ci:r${REVISION}-linux-gcc-4.9

docker build -t mbgl/ci:r${REVISION}-linux-gcc-5 -t mbgl/ci:latest-linux-gcc-5 linux-gcc-5
docker push mbgl/ci:r${REVISION}-linux-gcc-5

docker build -t mbgl/ci:r${REVISION}-linux-gcc-5-qt-4 --squash linux-gcc-5-qt-4
docker push mbgl/ci:r${REVISION}-linux-gcc-5-qt-4

docker build -t mbgl/ci:r${REVISION}-linux-gcc-5-qt-5 --squash linux-gcc-5-qt-5
docker push mbgl/ci:r${REVISION}-linux-gcc-5-qt-5

docker build -t mbgl/ci:r${REVISION}-linux-gcc-6 --squash linux-gcc-6
docker push mbgl/ci:r${REVISION}-linux-gcc-6

docker build -t mbgl/ci:r${REVISION}-linux-gcc-7 --squash linux-gcc-7
docker push mbgl/ci:r${REVISION}-linux-gcc-7

docker build -t mbgl/ci:r${REVISION}-android -t mbgl/ci:latest-android --squash android
docker push mbgl/ci:r${REVISION}-android

docker build -t mbgl/ci:r${REVISION}-android-ndk-r15 -t mbgl/ci:latest-android-ndk-r15 --squash android-ndk-r15
docker push mbgl/ci:r${REVISION}-android-ndk-r15

docker build -t mbgl/ci:r${REVISION}-android-ndk-r15-gradle -t mbgl/ci:latest-android-ndk-r15-gradle --squash android-ndk-r15-gradle
docker push mbgl/ci:r${REVISION}-android-ndk-r15-gradle

docker build -t mbgl/ci:r${REVISION}-rtl-text -t mbgl/ci:latest-rtl-text --squash rtl-text
docker push mbgl/ci:r${REVISION}-rtl-text
