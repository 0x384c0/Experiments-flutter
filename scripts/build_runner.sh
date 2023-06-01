BASEDIR=$(realpath $(dirname "$0")/..)
for d in features/*/data; do
  echo "----- Running build_runner for $d -----"
  cd $BASEDIR/$d
  flutter packages pub run build_runner build
done