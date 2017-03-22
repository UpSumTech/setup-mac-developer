#!/usr/bin/env bash

install_nodes() {
  local node_version
  local arr=('5.0.0' \
    '6.0.0' \
  )
  for node_version in "${arr[@]}"; do
    . $HOME/.bash_profile && nvm install "$node_version"
  done
}

main() {
  install_nodes
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
