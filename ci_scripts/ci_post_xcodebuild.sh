#!/bin/sh
# https://prog.world/uploading-dsym-to-firebase-crashlytics-via-xcode-cloud/
set -e
if [[ -n $CI_ARCHIVE_PATH ]];
then
    echo "Archive path is available. Let's run dSYMs uploading script"
    # Move up to parent directory
    cd ..
    # Debug
    echo "Derived data path: $CI_DERIVED_DATA_PATH"
    echo "Archive path: $CI_ARCHIVE_PATH"
    # Crashlytics dSYMs script
    $CI_DERIVED_DATA_PATH/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols -gsp "$CI_PRIMARY_REPOSITORY_PATH/ios/GoogleService-Info.plist" -p ios $CI_ARCHIVE_PATH/dSYMs
else
    echo "Archive path isn't available. Unable to run dSYMs uploading script."
fi