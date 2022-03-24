#!/usr/bin/env bash

install_terraform_versions() {
  local terraform_version
  local arr=( '1.1.7' '0.15.5' )
  for terraform_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && tfenv install "$terraform_version"
  done
}

main() {
  install_terraform_versions
  echo '1.1.7' > $HOME/.terraform-version
  . $HOME/.bash_profile && tfenv use 1.1.7
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
