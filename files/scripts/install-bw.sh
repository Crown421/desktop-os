#!/usr/bin/env bash

set -oue pipefail

# url="https://vault.bitwarden.com/download/?app=cli&platform=linux"
url="https://github.com/bitwarden/sdk-sm/releases/download/bws-v0.5.0/bws-x86_64-unknown-linux-gnu-0.5.0.zip"

temp_dir=$(mktemp -dt bws.XXXXXX)
trap 'rm -rf "$temp_dir"' EXIT INT TERM
cd "$temp_dir"

if ! curl -fsSL -o bws.zip "$url"; then
    echo "Could not download archive"
    exit 1
fi

bindir='/usr/bin'

unzip bws.zip

mv bws "$bindir/"

$bindir/bws --version

