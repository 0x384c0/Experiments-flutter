#!/bin/bash
# Automated drift web setup. More at: https://drift.simonbinder.eu/web/

BASEDIR=$(realpath "$(dirname "$0")"/..)

# Define the file path for pubspec.lock
LOCKFILE=$BASEDIR"/pubspec.lock"
DEST_DIR=$BASEDIR"/web/drift"

# Function to extract the version of a given library
extract_version() {
  local lib_name="$1"
  awk -v lib="$lib_name" '$1 == lib {found=1} found && /version:/ {print $2; exit}' "$LOCKFILE" | tr -d '"'
}

# Extract versions for drift and sqlite3
DRIFT_VERSION=$(extract_version "drift:")
SQLITE3_VERSION=$(extract_version "sqlite3:")

# Check if versions were found
if [[ -z "$DRIFT_VERSION" || -z "$SQLITE3_VERSION" ]]; then
    echo "Could not find drift or sqlite3 versions in $LOCKFILE."
    exit 1
fi

echo "Found versions: Drift - $DRIFT_VERSION, SQLite3 - $SQLITE3_VERSION"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Define URLs for downloading files
DRIFT_WORKER_URL="https://github.com/simolus3/drift/releases/download/drift-$DRIFT_VERSION/drift_worker.js"
SQLITE3_WASM_URL="https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-$SQLITE3_VERSION/sqlite3.wasm"

# Download files to destination directory
curl -L -o "$DEST_DIR/drift_worker.js" "$DRIFT_WORKER_URL"
curl -L -o "$DEST_DIR/sqlite3.wasm" "$SQLITE3_WASM_URL"

echo "Downloaded drift_worker.js and sqlite3.wasm to $DEST_DIR"