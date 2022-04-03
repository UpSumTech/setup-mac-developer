#!/usr/bin/env bash

install_terraform_versions() {
  . "$HOME/.bash_profile"
  local terraform_version
  local arr=( '1.1.7' '1.1.0' '1.0.10' )
  for terraform_version in "${arr[@]}"; do
    tfenv install "$terraform_version"
  done
}

main() {
  install_terraform_versions
  . $HOME/.bash_profile && tfenv use 1.1.7
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
