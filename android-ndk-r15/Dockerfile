FROM mbgl/ci:r3-android

ENV ANDROID_NDK_HOME=/android/sdk/ndk-bundle

# --------------------------------------------------------------------------------------------------
# Install Android NDK

WORKDIR /android/sdk

# Use desired version from https://developer.android.com/ndk/downloads/index.html
# and update the checksum.
RUN set -eu \
 && curl -L --retry 3 https://dl.google.com/android/repository/android-ndk-r15-linux-x86_64.zip -o ndk.zip \
 && (echo "32b3115357ed798a8a48d7d589ffcb901693c745  ndk.zip" | sha1sum -c) \
 && unzip -q ndk.zip && rm ndk.zip && mv android-ndk-r* ndk-bundle

RUN set -eu \
 && mkdir -p "${ANDROID_HOME}/licenses" \
 && (echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license") \
 && tools/bin/sdkmanager "cmake;3.6.3155560" \
 && rm -rf "${ANDROID_HOME}/licenses"

WORKDIR /src
