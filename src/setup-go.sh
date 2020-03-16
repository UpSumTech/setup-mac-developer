#!/usr/bin/env bash

install_golangs() {
  local go_version
  local arr=('1.9.2' \
    '1.11.0' \
    '1.12beta1' \
  )
  for go_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && goenv install "$go_version"
  done
}

main() {
  install_golangs
  . $HOME/.bash_profile && goenv global 1.12beta1
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
