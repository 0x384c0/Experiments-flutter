# !/bin/sh
BASEDIR=$(realpath "$(dirname "$0")"/../apps/app_main/ui_tests)

cd $BASEDIR

source venv/bin/activate

python -m pytest --gherkin-terminal-reporter --disable-pytest-warnings