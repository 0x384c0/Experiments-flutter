# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

info () {
	echo "$(tput setaf 2; tput bold;)INFO: $1$(tput sgr0)"
}

# Use 'find' to locate 'l10n.yaml' files, excluding directories starting with a dot
for dir in $(find "$BASEDIR" -type f -name "l10n.yaml" ! -path "*/.*" -exec dirname {} \;); do
  # Print the current working directory
  info "Working directory: $dir"

  # Change to the directory and run 'flutter gen-l10n'
  (cd "$dir" && flutter gen-l10n)
done