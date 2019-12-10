#!/usr/bin/env bash

install_rubies() {
  local ruby_version
  local arr=('2.4.0' \
    '2.5.0' \
  )
  for ruby_version in "${arr[@]}"; do
    rbenv install "$ruby_version"
  done
}

main() {
  install_rubies
  . $HOME/.bash_profile && rbenv global 2.4.0 && rbenv rehash
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
