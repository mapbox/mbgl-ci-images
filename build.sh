#!/usr/bin/env bash

set -eu
cd "$(dirname "${BASH_SOURCE[0]}")"

PUSH=false
ID="${CIRCLE_SHA1:-latest}"

function usage {
    echo "Usage: $0 [args] <image>"
    echo ""
    echo "Arguments:"
    echo "    -p, --push       Pushes the resulting image to Docker Hub (only for builds with an ID)"
    echo "    -i, --id         Specifies the ID of the image. Defaults to \`${CIRCLE_SHA1:-latest}\`"
    exit 1
}

declare -a ARGS
while [ $# -gt 0 ]; do
    case "$1" in
        -p|--push)
            PUSH=true
            shift
            ;;
        -i|--id)
            if [ -z "${2:-}" ]; then
                echo -e "\033[31m$1 is missing an argument\033[0m\n"
                usage
            fi
            ID="${2}"
            shift
            shift
            ;;
        -*)
            echo "Unknown argument $1"
            usage
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done
if [ ${#ARGS[@]} -ne 0 ]; then
    set -- "${ARGS[@]}"
fi

if [ -z "${1:-}" ]; then
    usage
fi
IMAGE="$1"

if [ ! -r "images/$IMAGE" ]; then
    echo "Can't find image $IMAGE"
    exit 1
fi

if [ $PUSH = true ] && [ "$ID" == "latest" ]; then
    echo -e "\033[31mCan't push images without a named ID. Try setting CIRCLE_SHA1 to the commit sha\033[0m\n"
    usage
fi

# Add HTTP proxy for local testing if there is an apt-proxy running
# Run scripts/apt-proxy.sh locally to start.
PREFIX=
if nc -z localhost 3142 2>/dev/null; then
    PREFIX=$'\n''RUN echo "Acquire::http { Proxy \\"http://host.docker.internal:3142\\"; };" >> /etc/apt/apt.conf.d/01proxy'
fi

# Add prefix to the Docker file and pipe it into stdin
sed -e '/^FROM /a\'"$PREFIX" "images/$IMAGE" | docker build -t "mbgl/$IMAGE:${ID:0:10}" images -f -

if [ $PUSH = true ]; then
    docker tag "mbgl/$IMAGE:${ID:0:10}" "mbgl/$IMAGE:latest"
    docker push "mbgl/$IMAGE:${ID:0:10}"
    docker push "mbgl/$IMAGE:latest"
fi
