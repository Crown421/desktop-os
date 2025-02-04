#!/usr/bin/env bash

set -oue pipefail

url="https://vault.bitwarden.com/download/?app=cli&platform=linux"

temp_dir=$(mktemp -dt bw.XXXXXX)
trap 'rm -rf "$temp_dir"' EXIT INT TERM
cd "$temp_dir"

if ! curl -fsSL -o bw.zip "$url"; then
    echo "Could not download archive"
    exit 1
fi

bindir='/usr/bin'

unzip bw.zip

mv bw "$bindir/"

$bindir/bw --version

