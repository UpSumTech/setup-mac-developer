#!/usr/bin/env bash

install_solarized_theme() {
  mkdir -p $HOME/lib
  cd $HOME/lib
  git clone https://github.com/altercation/solarized.git
}

configure_iterm() {
  curl -H 'Cache-Control: no-cache' -s -S -L https://raw.githubusercontent.com/sumanmukherjee03/iterm2-setup/master/bootstrap.sh | bash
}

main() {
  install_solarized_theme
  configure_iterm
  # TODO: Import the solarized colour scheme into iterm2 or else if it already comes with it then activate it
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
