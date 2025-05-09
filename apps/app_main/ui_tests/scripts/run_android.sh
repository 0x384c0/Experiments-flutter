# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

cd $BASEDIR

source venv/bin/activate

cd appium_tests

python -m pytest --app-path='../../build/app/outputs/flutter-apk/app-release.apk'