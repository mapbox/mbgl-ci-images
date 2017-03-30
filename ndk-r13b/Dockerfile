FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8

ENV LC_ALL="en_US.UTF-8" \
    DEBIAN_FRONTEND="noninteractive" \
    ANDROID_HOME=/android/sdk \
    ANDROID_NDK_HOME=/android/sdk/ndk-bundle \
    GRADLE_OPTS=-Dorg.gradle.daemon=false

# --------------------------------------------------------------------------------------------------
# Install system packages

COPY *.list /etc/apt/sources.list.d/
COPY *.gpg /tmp/
RUN find /tmp/*.gpg | xargs -n1 apt-key add

RUN dpkg --add-architecture i386

RUN set -eu \
 && apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install git make curl unzip nodejs openjdk-8-jdk-headless google-cloud-sdk \
        libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# libsysconfcpus.so can be used to alter the number of CPUs reported by the system
COPY libsysconfcpus.so /usr/lib/

# --------------------------------------------------------------------------------------------------
# Install Android SDK

WORKDIR /android/sdk

# Use most recent version from https://dl.google.com/android/repository/repository-11.xml
# and update the checksum.
RUN curl -L --retry 3 https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -o tools.zip \
 && (echo "72df3aa1988c0a9003ccdfd7a13a7b8bd0f47fc1  tools.zip" | sha1sum -c) \
 && unzip -q tools.zip && rm tools.zip

RUN mkdir -p "${ANDROID_HOME}/licenses" \
 && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license"

RUN tools/bin/sdkmanager "platform-tools"
RUN tools/bin/sdkmanager "platforms;android-25"
RUN tools/bin/sdkmanager "build-tools;25.0.2"
RUN tools/bin/sdkmanager "extras;android;m2repository"
RUN tools/bin/sdkmanager "cmake;3.6.3155560"
RUN tools/bin/sdkmanager "patcher;v4"
RUN tools/bin/sdkmanager "extras;google;m2repository"

# Prevent automated installation of more packages during the build.
RUN rm -rf "${ANDROID_HOME}/licenses"

# --------------------------------------------------------------------------------------------------
# Install Android NDK

# Use desired version from https://developer.android.com/ndk/downloads/index.html
# and update the checksum.
RUN curl -L --retry 3 https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip -o ndk.zip \
 && (echo "0600157c4ddf50ec15b8a037cfc474143f718fd0  ndk.zip" | sha1sum -c) \
 && unzip -q ndk.zip && rm ndk.zip && mv android-ndk-r* ndk-bundle

# --------------------------------------------------------------------------------------------------
# Setup code

WORKDIR /src

RUN git clone https://github.com/mapbox/mapbox-gl-native.git . \
 && make android-checkstyle \
 && git clean -fdx
