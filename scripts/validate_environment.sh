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

# Upload
check_command bundle
echo "Bundler is installed."

# UI Tests
check_command npm
echo "Npm is installed."

check_command python3
echo "python3 is installed."
