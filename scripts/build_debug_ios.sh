# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

cd $BASEDIR

flutter build ios --simulator