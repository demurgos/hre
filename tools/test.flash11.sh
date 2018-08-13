#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to the root of the project
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
set -x
# Echo and run
cd "${PROJECT_ROOT}"
haxelib run munit gen test
haxe test.flash11.hxml
rm -rf build/test/firefox-profile/
cp -r tools/firefox-profile-template/ build/test/firefox-profile/
set +e
haxelib run munit run -browser "xvfb-run firefox -profile firefox-profile" -kill-browser -result-exit-code -as3 build/test.flash11.swf
TEST_RESULT="${?}"
set -e
set +x
echo "------------------------------"
echo "Summary for as3:"
cat build/report/test/summary/as3/summary.txt
echo -e "\n------------------------------"
set -x
exit "${TEST_RESULT}"
