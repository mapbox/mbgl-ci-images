#!/usr/bin/env bash

TAR=tar
if [ "$(uname -s)" = "Darwin" ]; then
    TAR=gtar
fi

function filesystem {
    NAME="$1"
    shift
    mkdir -p "images/filesystem"
    $TAR -c -j -f "images/filesystem/$NAME.tar.gz" --owner=0 --group=0 -C images/filesystem "$@"
    echo -e "\033[1mFilesystem $NAME:\033[0m"
    $TAR -t -v -f "images/filesystem/$NAME.tar.gz"
    echo
}

filesystem apt-google-cloud-sdk \
    tmp/google-cloud-sdk.gpg \
    etc/apt/sources.list.d/google-cloud-sdk.list

filesystem apt-toolchain \
    tmp/toolchain.gpg \
    etc/apt/sources.list.d/toolchain.list

filesystem apt-llvm \
    tmp/llvm.gpg \
    etc/apt/sources.list.d/llvm.list

filesystem libsysconfcpus \
    usr/lib/libsysconfcpus.so
