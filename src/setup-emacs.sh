THIS_DIR="$(cd "$(dirname $BASH_SOURCE[0])" && pwd)"
ROOT_DIR="$THIS_DIR/.."

export PID="$$" # Get parent pid so that you can kill the main proc from subshells
die() {
  echo >&2 "Error : $@"
  kill -s TERM $PID
  exit 1
}

install_emacs() {
  brew cask install emacs
  pip install jedi rope flake8 autopep8 yapf black
}

main() {
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
