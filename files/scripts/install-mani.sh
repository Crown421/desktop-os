#!/usr/bin/env bash

set -oue pipefail

url=$(
    curl -s https://api.github.com/repos/alajmo/mani/releases/latest |
    grep -wo -m1 "https://.*linux_amd64.tar.gz" || true
)

temp_dir=$(mktemp -dt mani.XXXXXX)
trap 'rm -rf "$temp_dir"' EXIT INT TERM
cd "$temp_dir"

if ! curl -fsSL -o mani.tar.gz "$url"; then
    echo "Could not download tarball"
    exit 1
fi

bindir='/usr/local/bin'

tar xzf mani.tar.gz

mv mani "$bindir/"

$bindir/mani --version
