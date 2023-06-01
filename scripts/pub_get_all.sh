BASEDIR=$(realpath $(dirname "$0")/..)
for d in features/*/*; do
  echo "----- Running pub get for $d -----"
  cd $BASEDIR/$d
  flutter pub get
done

cd $BASEDIR
flutter pub get