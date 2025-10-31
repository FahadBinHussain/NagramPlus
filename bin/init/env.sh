#!/bin/bash

# Detect ANDROID_HOME if not set
if [ -z "$ANDROID_HOME" ]; then
  if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
  elif [ -d "$HOME/.local/lib/android/sdk" ]; then
    export ANDROID_HOME="$HOME/.local/lib/android/sdk"
  fi
fi

# Force Linux NDK r27d first
if [ -z "$ANDROID_NDK_HOME" ]; then
  export ANDROID_NDK_HOME="$HOME/android-ndk/android-ndk-r27d"
fi

if [ -z "$NDK" ]; then
  export NDK="$ANDROID_NDK_HOME"
fi

# Check NDK exists
if [ ! -f "$NDK/source.properties" ]; then
  echo "Error: NDK not found at $NDK"
  exit 1
fi

# Export PROJECT path
export PROJECT=$(realpath .)

# Go environment setup (optional, only if needed)
if ! command -v go &> /dev/null; then
  if [ -d /usr/lib/go-1.16 ]; then
    export PATH=$PATH:/usr/lib/go-1.16/bin
  elif [ -d $HOME/.go ]; then
    export PATH=$PATH:$HOME/.go/bin
  fi
fi

if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

echo "ANDROID_HOME=$ANDROID_HOME"
echo "NDK=$NDK"
echo "ANDROID_NDK_HOME=$ANDROID_NDK_HOME"
