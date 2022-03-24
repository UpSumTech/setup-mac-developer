#!/usr/bin/env bash

install_terragrunt_versions() {
  local terragrunt_version
  local arr=( '0.36.0' '0.23.0' )
  for terragrunt_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && tgenv install "$terragrunt_version"
  done
}

main() {
  install_terragrunt_versions
  echo '0.36.0' > $HOME/.terragrunt-version
  . $HOME/.bash_profile && tgenv use 0.36.0
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
