#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
set -x
# Echo and run
cd "${PROJECT_ROOT}" && haxe main.flash8.hxml
