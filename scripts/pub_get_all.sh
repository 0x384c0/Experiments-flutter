BASEDIR=$(realpath "$(dirname "$0")"/..)
for d in features/*/*; do
  echo "----- Running pub get for $d -----"
  cd "$BASEDIR/$d" || exit
  flutter pub get
done

cd "$BASEDIR" || exit
flutter pub get