#!/usr/bin/env bash

install_pythons() {
  local python_version
  local arr=('2.7.14' \
    '3.4.4' \
  )
  for python_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && pyenv install "$python_version"
  done
}

main() {
  install_pythons
  . $HOME/.bash_profile && pyenv global 2.7.14 3.4.4
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
