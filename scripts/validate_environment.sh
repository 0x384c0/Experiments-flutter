# !/bin/bash
check_command() {
    command -v $1 >/dev/null 2>&1 || { echo >&2 "$1 is not installed. Aborting."; exit 1; }
}

check_command flutter
echo "Flutter is installed."

check_command bundle
echo "Bundler is installed."