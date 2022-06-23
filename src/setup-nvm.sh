#!/usr/bin/env bash

install_nodes() {
  . $HOME/.bash_profile
  . "$(brew --prefix)/opt/nvm/nvm.sh"
  command -v nvm
  local node_version
  local arr=('16.14.0' \
    '17.8.0' \
    '18.0.0' \
  )
  for node_version in "${arr[@]}"; do
    nvm install "$node_version"
  done
}

main() {
  install_nodes
  . $HOME/.bash_profile && nvm alias default 18.0.0 && { nvm use --delete-prefix v18.0.0 --silent; }
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
