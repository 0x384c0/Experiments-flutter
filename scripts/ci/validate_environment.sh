# !/bin/bash
check_command() {
  command -v $1 >/dev/null 2>&1 || {
    echo >&2 "$1 is not installed. Aborting."
    exit 1
  }
}

# Build
check_command flutter
echo "Flutter is installed."

check_command dart
dart pub global activate melos
echo "Dart is installed."

# Deploy
check_command bundle
echo "Bundler is installed."

# UI Tests
check_command npm
echo "Npm is installed."

check_command python3
echo "python3 is installed."

# Utils
check_command awk
echo "awk is installed."

check_command grep
echo "grep is installed."

check_command curl
echo "curl is installed."
