BASEDIR=$(realpath $(dirname "$0")/..)
cd $BASEDIR/features/weather/domain
flutter pub get
cd $BASEDIR/features/weather/data
flutter pub get
cd $BASEDIR/features/weather/presentation
flutter pub get
cd $BASEDIR
flutter pub get