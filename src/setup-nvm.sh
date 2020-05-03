#!/usr/bin/env bash

install_nodes() {
  local node_version
  local arr=('9.0.0' \
    '10.0.0' \
    '11.0.0' \
    '12.0.0' \
  )
  for node_version in "${arr[@]}"; do
    . $HOME/.bash_profile && nvm install "$node_version"
  done
}

main() {
  install_nodes
  . $HOME/.bash_profile && nvm alias default 11.0.0 && { nvm use --delete-prefix v11.0.0 --silent; }
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
