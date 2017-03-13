#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Dependencies
cd "$PROJECT_ROOT"/tools/
./flash8.build.sh
# Echo and run
CMD="cd \"$PROJECT_ROOT\" && xdg-open main.flash8.swf" && echo "$CMD" && eval "$CMD"
