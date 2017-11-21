FROM mbgl/ci:latest-java

ENV ANDROID_HOME=/android/sdk \
    GRADLE_OPTS=-Dorg.gradle.daemon=false

# --------------------------------------------------------------------------------------------------
# Install Android SDK

WORKDIR /android/sdk

# Use most recent version from https://dl.google.com/android/repository/repository-11.xml
# and update the checksum.
RUN set -eu \
 && curl -L --retry 3 https://dl.google.com/android/repository/platform-tools_r26.0.2-linux.zip -o tools.zip \
 && (echo "668ff8e319715175ff628ad52b124f154275fe2d  tools.zip" | sha1sum -c) \
 && unzip -q tools.zip && rm tools.zip

RUN set -eu \
 && mkdir -p "${ANDROID_HOME}/licenses" \
 && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license" \
 && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-preview-license"

RUN tools/bin/sdkmanager "platform-tools"
RUN tools/bin/sdkmanager "platforms;android-27"
RUN tools/bin/sdkmanager "platforms;android-26"
RUN tools/bin/sdkmanager "platforms;android-25"
RUN tools/bin/sdkmanager "build-tools;27.0.1"
RUN tools/bin/sdkmanager "build-tools;26.0.3"
RUN tools/bin/sdkmanager "extras;android;m2repository"
RUN tools/bin/sdkmanager "patcher;v4"
RUN tools/bin/sdkmanager "extras;google;m2repository"
RUN tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"

# Prevent automated installation of more packages during the build.
RUN rm -rf "${ANDROID_HOME}/licenses"

WORKDIR /src
