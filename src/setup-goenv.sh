#!/usr/bin/env bash

install_golangs() {
  local go_version
  local arr=( '1.23.1' '1.23.8' '1.24.2' )
  for go_version in "${arr[@]}"; do
    . "$HOME/.bashrc" && goenv install -f "$go_version"
  done
}

main() {
  install_golangs
  . "$HOME/.bashrc" && goenv global 1.24.2
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
