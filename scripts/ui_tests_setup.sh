# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/../ui_tests)

cd $BASEDIR

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment (venv)..."
    python3 -m venv venv
fi

source venv/bin/activate

pip install -r requirements.txt
npm ci