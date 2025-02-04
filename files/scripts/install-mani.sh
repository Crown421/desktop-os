#!/usr/bin/env sh

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
url=$(
    fetch https://api.github.com/repos/alajmo/mani/releases/latest |
    tac | tac | grep -wo -m1 "https://.*linux_amd64.tar.gz" || true
)

temp_dir=$(mktemp -dt mani.XXXXXX)
trap 'rm -rf "$temp_dir"' EXIT INT TERM
cd "$temp_dir"

if ! fetch mani.tar.gz "$url"; then
    echo "Could not download tarball"
    exit 1
fi

bindir='/usr/local/bin'

tar xzf mani.tar.gz

mv mani "$bindir/"

$bindir/mani version
