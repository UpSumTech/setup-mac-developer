#!/usr/bin/env bash

install_xcode() {
  # TODO: This will pause the script to download and install xcode
  # Use applescript to automate this part
  xcode-select -p || xcode-select --install
}

set_hostname() {
  # TODO: Ask for user feedback for the host name
  sudo scutil --set HostName suman-mbp
}

show_essential_dirs() {
  chflags nohidden ~/Library
}

create_essential_dirs_and_files() {
  mkdir ~/lib
  mkdir -p ~/var/run
  mkdir -p ~/var/log
  mkdir ~/bin
  mkdir ~/etc
  mkdir ~/tmp
}

main() {
  install_xcode
  set_hostname
  show_essential_dirs
  create_essential_dirs_and_files
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
