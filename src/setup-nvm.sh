#!/usr/bin/env bash

install_nodes() {
  local node_version
  local arr=('14.19.0' \
    '16.14.0' \
    '17.8.0' \
  )
  for node_version in "${arr[@]}"; do
    . $HOME/.bash_profile && nvm install "$node_version"
  done
}

main() {
  install_nodes
  . $HOME/.bash_profile && nvm alias default 16.14.0 && { nvm use --delete-prefix v16.14.0 --silent; }
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
