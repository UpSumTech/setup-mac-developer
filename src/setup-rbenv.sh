#!/usr/bin/env bash

install_rubies() {
  local ruby_version
  local arr=( '3.4.2' )
  . "$HOME/.bashrc"
  for ruby_version in "${arr[@]}"; do
    rbenv install -f "$ruby_version"
  done
}

main() {
  install_rubies
  . "$HOME/.bashrc" && rbenv global 3.4.2 && rbenv rehash
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
