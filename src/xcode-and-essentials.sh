#!/usr/bin/env bash

install_xcode() {
  # TODO: This will pause the script to download and install xcode
  # Use applescript to automate this part
  xcode-select -p || xcode-select --install
  softwareupdate --all --install --force # Update the software command line tools. This might take a while
  softwareupdate --install-rosetta --agree-to-license # This is needed for installing jdk
}

set_hostname() {
  # TODO: Ask for user feedback for the host name
  sudo scutil --set HostName workhorse
}

show_essential_dirs() {
  chflags nohidden $HOME/Library
}

create_essential_dirs_and_files() {
  mkdir -p $HOME/lib
  mkdir -p $HOME/var/run
  mkdir -p $HOME/var/log
  mkdir -p $HOME/bin
  mkdir -p $HOME/etc
  mkdir -p $HOME/tmp
}

main() {
  install_xcode
  set_hostname
  show_essential_dirs
  create_essential_dirs_and_files
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
