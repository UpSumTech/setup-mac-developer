#!/usr/bin/env bash

install_gvm() {
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
}

install_go1_4() {
  . $HOME/.bash_profile && gvm install go1.4
}

install_go_versions() {
  local go_version
  local arr=('go1.8' \
    'go1.7' \
    'go1.5' \
  )
  for go_version in "${arr[@]}"; do
    . $HOME/.bash_profile \
      && gvm use go1.4 \
      && gvm install "$go_version" -B
  done
}

main() {
  install_gvm
  install_go1_4
  install_go_versions
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
