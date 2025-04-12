#!/usr/bin/env bash

install_nodes() {
  . "$HOME/.bashrc"
  . "$(brew --prefix)/opt/nvm/nvm.sh"
  command -v nvm
  local node_version
  local arr=( '22.14.0' )
  for node_version in "${arr[@]}"; do
    nvm uninstall "$node_version"
    nvm install "$node_version"
  done
}

main() {
  install_nodes
  . "$HOME/.bashrc" && nvm alias default 22.14.0 && { nvm use --delete-prefix v22.14.0 --silent; }
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
