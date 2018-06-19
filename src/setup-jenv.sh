#!/usr/bin/env bash

add_javas_to_jenv() {
  local jdk
  for jdk in /Library/Java/JavaVirtualMachines/*; do
    jenv add "$jdk/Contents/Home/";
  done
}

enable_jenv_plugins() {
  . $HOME/.bash_profile && jenv enable-plugin maven
  . $HOME/.bash_profile && jenv enable-plugin ant
  . $HOME/.bash_profile && jenv enable-plugin export
  . $HOME/.bash_profile && jenv global 10.0
}

add_global_java_opts() {
  jenv global-options "-Xmx512m"
}

main() {
  add_javas_to_jenv
  add_global_java_opts
  enable_jenv_plugins
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
