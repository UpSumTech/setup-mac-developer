#!/usr/bin/env bash

install_nodes() {
  . $HOME/.bash_profile
  . "$(brew --prefix)/opt/nvm/nvm.sh"
  command -v nvm
  local node_version
  local arr=( '17.8.0' \
    '18.17.1' \
  )
  for node_version in "${arr[@]}"; do
    nvm install "$node_version"
  done
}

main() {
  install_nodes
  . $HOME/.bash_profile && nvm alias default 18.17.1 && { nvm use --delete-prefix v18.17.1 --silent; }
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
