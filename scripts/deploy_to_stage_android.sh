# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

info () {
	echo "$(tput setaf 2; tput bold;)INFO: $1$(tput sgr0)"
}

# Android
# CI setup https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane
info "Deploy Android to Firebase App Distribution"

cd $BASEDIR/android
bundle exec fastlane beta_android