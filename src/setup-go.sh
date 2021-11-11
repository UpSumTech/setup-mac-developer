#!/usr/bin/env bash

install_golangs() {
  local go_version
  local arr=( '1.14.0' '1.15.0' '1.16.0' )
  for go_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && goenv install "$go_version"
  done
}

main() {
  install_golangs
  . $HOME/.bash_profile && goenv global 1.16.0
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
