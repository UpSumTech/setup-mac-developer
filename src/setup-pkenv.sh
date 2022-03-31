#!/usr/bin/env bash

install_pkenv_versions() {
  . "$HOME/.bash_profile"
  local packer_version
  local arr=( '1.8.0' '1.7.5' )
  for packer_version in "${arr[@]}"; do
    PKENV_ARCH=$(uname -m) pkenv install "$packer_version"
  done
}

main() {
  install_pkenv_versions
  echo '1.8.0' > $HOME/.packer-version
  . $HOME/.bash_profile && pkenv use 1.8.0
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
