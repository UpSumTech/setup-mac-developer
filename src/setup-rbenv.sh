#!/usr/bin/env bash

install_rubies() {
  local ruby_version
  local arr=('2.4.0' \
    'jruby-9.1.7.0' \
  )
  for ruby_version in "${arr[@]}"; do
    rbenv install "$ruby_version"
  done
}

# fix_openssl() {
  # brew link --force openssl
# }

main() {
  install_rubies
  # fix_openssl
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
