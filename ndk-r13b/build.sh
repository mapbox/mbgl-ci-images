#!/usr/bin/env bash

set -euo pipefail

docker build -t mbgl/android-ci:ndk-r13b ndk-r13b
