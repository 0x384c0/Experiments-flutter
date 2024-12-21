# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

info () {
	echo "$(tput setaf 2; tput bold;)INFO: $1$(tput sgr0)"
}

# Use 'find' to locate 'pubspec.yaml' files, excluding directories starting with a dot
for dir in $(find "$BASEDIR" -type f -name "pubspec.yaml" ! -path "*/.*" -exec dirname {} \;); do
  if [ -d "$dir/test" ]; then
    # Print the current working directory
    info "Working directory: $dir"

    # Change to the directory and run 'flutter pub get'
    (cd "$dir" && flutter test) # replace get with upgrade to update all libraries
  fi
done