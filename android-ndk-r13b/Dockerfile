FROM mbgl/ci:latest-android

ENV ANDROID_NDK_HOME=/android/sdk/ndk-bundle

# --------------------------------------------------------------------------------------------------
# Install Android NDK

WORKDIR /android/sdk

# Use desired version from https://developer.android.com/ndk/downloads/index.html
# and update the checksum.
RUN set -eu \
 && curl -L --retry 3 https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip -o ndk.zip \
 && (echo "0600157c4ddf50ec15b8a037cfc474143f718fd0  ndk.zip" | sha1sum -c) \
 && unzip -q ndk.zip && rm ndk.zip && mv android-ndk-r* ndk-bundle

RUN set -eu \
 && mkdir -p "${ANDROID_HOME}/licenses" \
 && (echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license") \
 && tools/bin/sdkmanager "cmake;3.6.3155560" \
 && rm -rf "${ANDROID_HOME}/licenses"

WORKDIR /src
