#!/usr/bin/env bash

install_solarized_theme() {
  cd ~/lib
  git clone https://github.com/altercation/solarized.git
}

configure_iterm() {
  curl -H 'Cache-Control: no-cache' -s -S -L https://raw.githubusercontent.com/sumanmukherjee03/iterm2-setup/master/bootstrap.sh | bash
}

main() {
  install_solarized_theme
  configure_iterm
  # TODO: Import the solarized colour scheme into iterm2
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
