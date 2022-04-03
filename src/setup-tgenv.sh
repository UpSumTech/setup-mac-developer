#!/usr/bin/env bash

install_terragrunt_versions() {
  . "$HOME/.bash_profile"
  local terragrunt_version
  local arr=( '0.36.0' '0.30.0' )
  for terragrunt_version in "${arr[@]}"; do
    TGENV_ARCH=$(uname -m) tgenv install "$terragrunt_version"
  done
}

main() {
  install_terragrunt_versions
  . $HOME/.bash_profile && tgenv use 0.36.0
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
