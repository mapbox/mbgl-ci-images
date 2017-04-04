#!/usr/bin/env bash

# set REVISION=1 to build a new revision and push it to Docker Hub

set -euo pipefail

# Base images
docker build -t mbgl/ci:latest-base --squash base
docker build -t mbgl/ci:latest-linux --squash linux
docker build -t mbgl/ci:latest-java --squash java

# Final images
docker build -t mbgl/ci:r${REVISION}-linux-clang-3.9 --squash linux-clang-3.9
docker push mbgl/ci:r${REVISION}-linux-clang-3.9

docker build -t mbgl/ci:r${REVISION}-linux-clang-4 --squash linux-clang-4
docker push mbgl/ci:r${REVISION}-linux-clang-4

docker build -t mbgl/ci:r${REVISION}-linux-gcc-4.9 --squash linux-gcc-4.9
docker push mbgl/ci:r${REVISION}-linux-gcc-4.9

docker build -t mbgl/ci:r${REVISION}-linux-gcc-5 linux-gcc-5
docker push mbgl/ci:r${REVISION}-linux-gcc-5

docker build -t mbgl/ci:r${REVISION}-linux-gcc-6 --squash linux-gcc-6
docker push mbgl/ci:r${REVISION}-linux-gcc-6

docker build -t mbgl/ci:r${REVISION}-android -t mbgl/ci:latest-android --squash android
docker push mbgl/ci:r${REVISION}-android

docker build -t mbgl/ci:r${REVISION}-android-ndk-r13b -t mbgl/ci:latest-android-ndk-r13b --squash android-ndk-r13b
docker push mbgl/ci:r${REVISION}-android-ndk-r13b

docker build -t mbgl/ci:r${REVISION}-android-ndk-r13b-gradle -t mbgl/ci:latest-android-ndk-r13b-gradle --squash android-ndk-r13b-gradle
docker push mbgl/ci:r${REVISION}-android-ndk-r13b-gradle
