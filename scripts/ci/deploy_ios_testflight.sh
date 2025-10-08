#!/bin/sh
set -e

BASEDIR=$(realpath "$(dirname "$0")"/..)

info() {
  echo "$(tput setaf 2; tput bold;)INFO: $1$(tput sgr0)"
}

if [ "$#" -lt 2 ]; then
  echo "Usage1: $0 <API_KEY> <API_ISSUER>"
  echo "Usage2: KEY_FILE=key_file.txt && $0 \$(head -n 1 \"\$KEY_FILE\") \$(sed -n '2p' \"\$KEY_FILE\")"
  echo "key_file.txt must have API key on line 1 and API issuer on line 2"
  exit 1
fi

API_KEY=$1
API_ISSUER=$2

info "Deploying iOS app to TestFlight"
cd "$BASEDIR"

info "Building IPA..."
flutter build ipa

info "Upload IPA to App Store Connect..."
xcrun altool --upload-app \
  --type ios \
  -f "$BASEDIR"/build/ios/ipa/*.ipa \
  --apiKey "$API_KEY" \
  --apiIssuer "$API_ISSUER"
