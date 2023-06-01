BASEDIR=$(realpath $(dirname "$0")/..)
for d in features/*/presentation; do
  echo "----- Generating translations for $d -----"
  cd $BASEDIR/$d
  flutter gen-l10n
done