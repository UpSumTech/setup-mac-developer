#!/usr/bin/env bash

add_sdkman() {
  curl -s "https://get.sdkman.io" | bash
  if !cat $HOME/.bash_profile | grep -i 'sdkman'; then
    echo 'export SDKMAN_DIR="$HOME/.sdkman"' >> $HOME/.bash_profile
    echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . "$HOME/.sdkman/bin/sdkman-init.sh"' >> $HOME/.bash_profile
  fi
  echo -n ''
}

install_groovy_through_sdkman() {
  sdk install groovy
}

main() {
  add_sdkman
  install_groovy_through_sdkman
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
