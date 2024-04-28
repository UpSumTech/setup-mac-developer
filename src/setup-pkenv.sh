#!/usr/bin/env bash

install_pkenv_versions() {
  . "$HOME/.bash_profile"
  local packer_version
  local arr=( '1.10.2' )
  for packer_version in "${arr[@]}"; do
    PKENV_ARCH=$(uname -m) pkenv install "$packer_version"
  done
}

main() {
  install_pkenv_versions
  echo '1.10.2' > $HOME/.packer-version
  . $HOME/.bash_profile && pkenv use 1.10.2
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
