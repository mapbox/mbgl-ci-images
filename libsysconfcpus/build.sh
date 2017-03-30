#!/usr/bin/env bash

set -euo pipefail

docker build -t mbgl/android-ci:libsysconfcpus libsysconfcpus
docker run -t mbgl/android-ci:libsysconfcpus ls -la /libsysconf/install/lib/libsysconfcpus.so.0.0.0
docker cp `docker ps -l -q`:/libsysconf/install/lib/libsysconfcpus.so.0.0.0 .
