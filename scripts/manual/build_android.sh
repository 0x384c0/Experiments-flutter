set -e

# this script assumes that sh-android-sdk and sh-test-app are located in the same directory unless a path is provided
APP_DIR=$(realpath "$(dirname "$0")")/..

# Extract app version
app_version=$($APP_DIR/scripts/get_version.sh)

# Get current date in (MM-DD) format
current_date=$(date +"%m-%d")

# Set APK name
apk_name="app-release-v${app_version} (${current_date}).apk"

cd $APP_DIR
flutter build apk --release

# Rename the APK
mv "$APP_DIR/build/app/outputs/flutter-apk/app-release.apk" \
   "$APP_DIR/build/app/outputs/flutter-apk/$apk_name"

open "$APP_DIR/build/app/outputs/flutter-apk/"

echo "APK built and renamed to: $apk_name"
