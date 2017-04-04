FROM mbgl/ci:latest-java

ENV ANDROID_HOME=/android/sdk \
    GRADLE_OPTS=-Dorg.gradle.daemon=false

# --------------------------------------------------------------------------------------------------
# Install Android SDK

WORKDIR /android/sdk

# Use most recent version from https://dl.google.com/android/repository/repository-11.xml
# and update the checksum.
RUN set -eu \
 && curl -L --retry 3 https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -o tools.zip \
 && (echo "72df3aa1988c0a9003ccdfd7a13a7b8bd0f47fc1  tools.zip" | sha1sum -c) \
 && unzip -q tools.zip && rm tools.zip

RUN set -eu \
 && mkdir -p "${ANDROID_HOME}/licenses" \
 && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license"

RUN tools/bin/sdkmanager "platform-tools"
RUN tools/bin/sdkmanager "platforms;android-25"
RUN tools/bin/sdkmanager "build-tools;25.0.2"
RUN tools/bin/sdkmanager "extras;android;m2repository"
RUN tools/bin/sdkmanager "patcher;v4"
RUN tools/bin/sdkmanager "extras;google;m2repository"

# Prevent automated installation of more packages during the build.
RUN rm -rf "${ANDROID_HOME}/licenses"

WORKDIR /src
