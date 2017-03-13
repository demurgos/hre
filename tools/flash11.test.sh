#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Echo and run
CMD="cd \"$PROJECT_ROOT\"" && echo "$CMD" && eval "$CMD"
CMD="haxelib run munit gen test" && echo "$CMD" && eval "$CMD"
CMD="haxelib run openfl build test.flash11.lime flash" && echo "$CMD" && eval "$CMD"
CMD="rm -rf build/test/firefox-profile/" && echo "$CMD" && eval "$CMD"
CMD="cp -r tools/firefox-profile-template/ build/test/firefox-profile/" && echo "$CMD" && eval "$CMD"
set +e
CMD="haxelib run munit run -browser \"firefox -profile firefox-profile\" -kill-browser -result-exit-code -as3" && echo "$CMD" && eval "$CMD"
echo "------------------------------"
echo "Summary for as3:"
cat build/report/test/summary/as3/summary.txt
echo ""
echo "------------------------------"
