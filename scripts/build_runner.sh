cd "$(dirname "$0")/../"
for d in features/*/data; do
  (echo "Running build_runner for $d"; cd $d;flutter packages pub run build_runner build)
done