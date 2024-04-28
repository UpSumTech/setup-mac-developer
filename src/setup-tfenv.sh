#!/usr/bin/env bash

install_terraform_versions() {
  . "$HOME/.bash_profile"
  local terraform_version
  local arr=( '1.8.1' )
  for terraform_version in "${arr[@]}"; do
    tfenv install "$terraform_version"
  done
}

main() {
  install_terraform_versions
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  mkdir -p "$TF_PLUGIN_CACHE_DIR"
  . $HOME/.bash_profile && tfenv use 1.8.1
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
