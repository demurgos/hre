#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Dependencies
# TODO: Do not run tests if --no-test is passed
#cd "$PROJECT_ROOT"/tools/
#./test.sh
cd "$PROJECT_ROOT"

# Absolute path to a random temporary directory
TMP_ROOT=`mktemp -d`

# Copy the files to publish
cp ./LICENSE.md "$TMP_ROOT/LICENSE.md"
cp ./README.md "$TMP_ROOT/README.md"
cp ./haxelib.json "$TMP_ROOT/haxelib.json"
cp -r ./src/ "$TMP_ROOT/src/"

# Archive path
ARCHIVE_PATH="$PROJECT_ROOT/build/hre.zip"
# Build archive
# cd "$TMP_ROOT" && tar --create --gzip --file="$ARCHIVE_PATH" .
cd "$TMP_ROOT" && zip --quiet --recurse-paths "$ARCHIVE_PATH" *

# Clean up
rm -r "$TMP_ROOT"

echo "$ARCHIVE_PATH"
