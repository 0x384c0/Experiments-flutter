# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/../apps/app_main)

cd $BASEDIR

flutter build ios --simulator