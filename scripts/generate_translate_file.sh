BASEDIR=$(realpath "$(dirname "$0")"/..)
for file in features/*/*/l10n.yaml; do
  d="$(dirname "$file")"
  echo "----- Generating translations for $d -----"
  cd "$BASEDIR/$d" || exit
  flutter gen-l10n
done