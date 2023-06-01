BASEDIR=$(realpath $(dirname "$0")/..)
for d in features/*/*; do
  echo "----- Cleaning $d -----"
  cd $BASEDIR/$d
  flutter clean
done

cd $BASEDIR
flutter clean