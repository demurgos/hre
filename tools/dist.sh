#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
set -x

# Absolute path to a random temporary directory
TMP_ROOT="$(mktemp -d)"

# Read version
VERSION="$(jq -r .version haxelib.json)"

# Copy the files to publish
cp ./CHANGELOG.md "${TMP_ROOT}/CHANGELOG.md"
cp ./LICENSE.md "${TMP_ROOT}/LICENSE.md"
cp ./README.md "${TMP_ROOT}/README.md"
cp ./haxelib.json "${TMP_ROOT}/haxelib.json"
cp -r ./src/ "${TMP_ROOT}/src/"

# Archive path
ARCHIVE_PATH="${PROJECT_ROOT}/build/hre-${VERSION}.zip"
# Build archive
(shopt -s dotglob && cd "${TMP_ROOT}" && zip --quiet --recurse-paths "${ARCHIVE_PATH}" *)

# Clean up
rm -r "${TMP_ROOT}"

set +x
echo "SUCCESS, run the following command to publish:"
echo "haxelib submit ${ARCHIVE_PATH}"
