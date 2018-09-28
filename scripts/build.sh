#!/usr/bin/env bash

set -eu

# Extract [docker:name] tags from the most recent commit message.
# To build tags from multiple commits, push them individually.
IMAGES=$(git log -1 --pretty=format:'%B' "${CIRCLE_SHA1:-HEAD}" | \
    grep -o "\\[\\s*docker\\s*:[^]]\\+\\]" | \
    cut -d ':' -f 2 | cut -d ']' -f 1 | sed 's/^ *//;s/ *$//' | sort | uniq)

# Try to run the Docker image buid for every tag mentioned in a commit message in this branch.
while read -r IMAGE; do
    if [ ! -z "$IMAGE" ]; then
        if [ ! -r "images/$IMAGE" ]; then
            echo "Can't find image $IMAGE"
            exit 1
        fi

        echo -e "\033[1mBuilding $IMAGE...\033[0m"
        ./build.sh "$IMAGE" --push
    fi
done <<<"$IMAGES"
