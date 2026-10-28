#!/usr/bin/env bash

install_pkenv_versions() {
  . "$HOME/.bashrc"
  local packer_version
  local arr=( '1.16.2' )
  for packer_version in "${arr[@]}"; do
    PKENV_ARCH="$(uname -m)" pkenv install "$packer_version"
  done
}

main() {
  install_pkenv_versions
  echo '1.16.2' > "$HOME/.packer-version"
  . "$HOME/.bashrc" && pkenv use 1.16.2
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
