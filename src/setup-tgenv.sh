#!/usr/bin/env bash

install_terragrunt_versions() {
  . "$HOME/.bashrc"
  local terragrunt_version
  local arr=( '0.77.12' )
  for terragrunt_version in "${arr[@]}"; do
    TGENV_ARCH="$(uname -m)" tgenv install "$terragrunt_version"
  done
}

main() {
  install_terragrunt_versions
  . "$HOME/.bashrc" && tgenv use 0.77.12
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
