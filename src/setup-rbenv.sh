#!/usr/bin/env bash

install_rubies() {
  local ruby_version
  local arr=('2.4.0' \
  )
  for ruby_version in "${arr[@]}"; do
    CONFIGURE_OPTS='--enable-shared' rbenv install "$ruby_version"
  done
}

# fix_openssl() {
  # brew link --force openssl
# }

main() {
  install_rubies
  . $HOME/.bash_profile && rbenv global 2.4.0 && rbenv rehash
  # fix_openssl
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
