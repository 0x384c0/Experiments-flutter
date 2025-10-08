set -e

# this script assumes that sh-ios-sdk and sh-test-app are located in the same directory unless a path is provided
SH_TEST_APP_DIR=$(realpath "$(dirname "$0")")/..

cd $SH_TEST_APP_DIR
flutter build ipa

open $SH_TEST_APP_DIR/build/ios/ipa