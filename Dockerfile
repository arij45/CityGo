# Use the official Flutter image as the base image
FROM ubuntu:20.04
# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive
# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk wget libxml2-utils
# Set environment variables for Android SDK
ENV ANDROID_SDK_ROOT="/usr/local/android-sdk"
ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
ENV ANDROID_VERSION="29"
ENV ANDROID_BUILD_TOOLS_VERSION="29.0.3"
# Prepare Android directories and system variables
RUN mkdir -p $ANDROID_SDK_ROOT \
  && mkdir -p /root/.android \
  && touch /root/.android/repositories.cfg
# Download and install Android SDK tools
RUN curl -o android_tools.zip $ANDROID_TOOLS_URL \
  && unzip -qq -d "$ANDROID_SDK_ROOT" android_tools.zip \
  && rm android_tools.zip \
  && mv $ANDROID_SDK_ROOT/cmdline-tools $ANDROID_SDK_ROOT/latest \
  && mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
  && mv $ANDROID_SDK_ROOT/latest $ANDROID_SDK_ROOT/cmdline-tools/latest
# Set Java Environment Variables
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
# Accept Android SDK licenses and install required components
RUN yes "y" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
  && yes "y" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platforms;android-$ANDROID_VERSION" \
  && yes "y" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platform-tools"
# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /home/developer/flutter
# Add Flutter to the PATH
ENV PATH "$PATH:/home/developer/flutter/bin"
# Run basic check to download Dart SDK
RUN flutter doctor
# Create a directory for your Flutter project
RUN mkdir -p /home/developer/my_flutter_app
# Copy your Flutter project files to the Docker image
COPY ./ /home/developer/my_flutter_app
# Set the working directory to your Flutter project
WORKDIR /home/developer/my_flutter_app
# Run Flutter commands to build your app
RUN flutter pub get
RUN flutter build apk
