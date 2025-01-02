# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/../apps/app_main/adnroid)

cd $BASEDIR

./gradlew assembleRelease appDistributionUploadRelease