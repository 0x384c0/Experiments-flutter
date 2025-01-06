# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

cd $BASEDIR

python3 -c 'import venv' >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "venv is already installed."
else
    echo "venv is not installed. Installing..."
    python3 -m ensurepip
    python3 -m pip install venv
    echo "venv has been installed."
fi

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment (venv)..."
    python3 -m venv venv
fi

source venv/bin/activate

pip install -r requirements.txt
npm ci