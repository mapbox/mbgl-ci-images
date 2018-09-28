#!/usr/bin/env bash

# Run this script to use a local APT proxy while creating new scripts.

set -eu

docker build -t "mbgl/apt-cacher-ng:latest" images -f images/apt-cacher-ng

docker run -p 3142:3142 "mbgl/apt-cacher-ng:latest"
