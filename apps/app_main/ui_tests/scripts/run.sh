# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/..)

cd $BASEDIR

source venv/bin/activate

python -m pytest -q --tb=short -v --gherkin-terminal-reporter --disable-pytest-warnings