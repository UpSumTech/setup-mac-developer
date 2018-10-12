#!/usr/bin/env bash

add_sdkman() {
  curl -s "https://get.sdkman.io" | bash
}

install_groovy_through_sdkman() {
  sdk install groovy
}

main() {
  add_sdkman
  install_groovy_through_sdkman
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
