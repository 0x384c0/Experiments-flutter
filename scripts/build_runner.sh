# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

info () {
	echo "$(tput setaf 2; tput bold;)INFO: $1$(tput sgr0)"
}

# Use 'find' to locate 'pubspec.yaml' files, excluding directories starting with a dot
for dir in $(find "$BASEDIR" -type f -name "pubspec.yaml" ! -path "*/.*" -exec dirname {} \;); do
  if grep -q "build_runner:" "$dir/pubspec.yaml"; then
    # Print the current working directory
    info "Working directory: $dir"

    # Change to the directory and run build_runner
    (cd "$dir" && dart run build_runner build --delete-conflicting-outputs)
  fi
done