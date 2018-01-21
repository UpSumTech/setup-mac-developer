#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${THIS_DIR}/.."

get_requirements() {
  mkdir -p "$HOME/.minishift/config"
  cp "$ROOT_DIR/templates/minishift/config.json" "$HOME/.minishift/config/config.json"
}

prep_minishift() {
  (minishift status | grep -i running || minishift start) &
  wait
  minishift console --url
}

post_startup_mods() {
  command -v oc || { echo "The openshift client could not be found"; exit 1; }
  oc completion bash > "$HOME/.oc-completion"
  echo '. "$HOME/.oc-completion"' >> "$HOME/.bash_profile"
  . "$HOME/.bash_profile" && gem install rhc
  rhc setup --autocomplete
  echo '. "$HOME/.openshift/bash_autocomplete"' >> "$HOME/.bash_profile"
}

main() {
  get_requirements
  prep_minishift
  post_startup_mods
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
