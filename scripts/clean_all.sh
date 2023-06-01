BASEDIR=$(realpath "$(dirname "$0")"/..)
for d in features/*/*; do
  echo "----- Cleaning $d -----"
  cd "$BASEDIR/$d" || exit
  flutter clean
done

cd "$BASEDIR" || exit
flutter clean