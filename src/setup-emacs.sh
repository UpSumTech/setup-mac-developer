#! /usr/bin/env bash

install_emacs() {
  . "$HOME/.bashrc"
  brew install emacs
  python3 -m pip install jedi rope flake8 autopep8 yapf black
}

main() {
  install_emacs
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
