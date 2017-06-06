#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Echo and run
CMD="cd \"$PROJECT_ROOT\" && haxelib run openfl build main.flash11.lime flash" && echo "$CMD" && eval "$CMD"
