#!/usr/bin/env bash

install_pkenv_versions() {
  local packer_version
  local arr=( '1.8.0' '1.7.0' '1.6.0' )
  for packer_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && pkenv install "$packer_version"
  done
}

main() {
  install_pkenv_versions
  echo '1.8.0' > $HOME/.packer-version
  . $HOME/.bash_profile && pkenv use 1.8.0
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
