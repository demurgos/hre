#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Echo and run
echo "Installing lime 2.3.3"
CMD="haxelib install lime 2.3.3 > /dev/null" && echo "$CMD" && eval "$CMD"
echo "Installing munit 2.1.2"
CMD="haxelib install munit 2.1.2 > /dev/null" && echo "$CMD" && eval "$CMD"
echo "Installing openfl 3.0.1"
CMD="haxelib install openfl 3.0.1 > /dev/null" && echo "$CMD" && eval "$CMD"
echo "Installing tink_core 1.6.2"
CMD="haxelib install tink_core 1.6.2 > /dev/null" && echo "$CMD" && eval "$CMD"
