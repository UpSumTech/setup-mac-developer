#!/usr/bin/env bash

add_javas_to_jenv() {
  local jdk
  for jdk in /Library/Java/JavaVirtualMachines/*; do
    jenv add "$jdk/Contents/Home/";
  done
}

enable_jenv_plugins() {
  . $HOME/.bash_profile
  jenv sh-enable-plugin maven
  jenv sh-enable-plugin ant
  jenv sh-enable-plugin export
  jenv global 11.0
}

main() {
  add_javas_to_jenv
  enable_jenv_plugins
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
