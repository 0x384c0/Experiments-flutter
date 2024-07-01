#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 $HOME/flutter # --branch "3.4.3"
export PATH="$PATH:$HOME/flutter/bin"

flutter --version

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
cd ios && pod install # run `pod install` in the `ios` directory.

# Custom commands
cd ../
sh scripts/build_runner.sh

if [ -n "$XC_CLOUD_FLUTTER_APP_FLAVOR" ]; then # XC_CLOUD_FLUTTER_APP_FLAVOR should be set in workflow in Xcode cloud
    echo "XC_CLOUD_FLUTTER_APP_FLAVOR is set to '$XC_CLOUD_FLUTTER_APP_FLAVOR'"
    flutter build ios --release --no-codesign --flavor "$XC_CLOUD_FLUTTER_APP_FLAVOR"
else
    echo "XC_CLOUD_FLUTTER_APP_FLAVOR is not set. Continuing without running flutter build."
fi
cd ios

exit 0
