REPOSITORY_ROOT=$(realpath "$(dirname "$0")")/..
grep '^version:' $REPOSITORY_ROOT/pubspec.yaml | sed -E 's/version: ()/\1/'