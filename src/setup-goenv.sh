#!/usr/bin/env bash

install_golangs() {
  local go_version
  local arr=( '1.26.10' '1.27.3' )
  for go_version in "${arr[@]}"; do
    . "$HOME/.bashrc" && goenv install -f "$go_version"
  done
}

main() {
  install_golangs
  . "$HOME/.bashrc" && goenv use 1.26.10 --global
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
