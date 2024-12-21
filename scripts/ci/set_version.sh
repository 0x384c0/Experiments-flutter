#!/bin/bash

version=$(git rev-list --all --count)
file="apps/app_main/pubspec.yaml"

# Use sed to replace the patch version
new_version=$(cat "$file" | sed -E "s/(version: [0-9]+\.[0-9]+\.[0-9]+\+)[0-9]+/\1$version/")

# Output the updated version to the file
echo "$new_version" > "$file"

echo "Patch version in pubspec.yaml has been updated to $version."
