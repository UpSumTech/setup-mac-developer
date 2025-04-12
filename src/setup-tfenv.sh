#!/usr/bin/env bash

install_terraform_versions() {
  . "$HOME/.bashrc"
  local terraform_version
  local arr=( '1.10.2' )
  for terraform_version in "${arr[@]}"; do
    tfenv install "$terraform_version"
  done
}

main() {
  install_terraform_versions
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  mkdir -p "$TF_PLUGIN_CACHE_DIR"
  . $HOME/.bash_profile && tfenv use 1.10.2
  echo "1.10.2" > "$HOME/.terraform-version"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
