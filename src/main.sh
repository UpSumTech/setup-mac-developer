#!/usr/bin/env bash

set -e -o pipefail

main() {
  export USER_EMAIL="$1"
  export USER_FULLNAME="$2"

  ./src/xcode-and-essentials.sh
  ./src/setup-bash.sh
  ./src/setup-homebrew-and-packages.sh
  ./src/setup-git.sh
  ./src/setup-iterm2.sh
  ./src/setup-mysql.sh
  ./src/setup-pyenv.sh
  ./src/setup-rbenv.sh
  ./src/setup-nvm.sh
  ./src/setup-jenv.sh
  ./src/setup-go.sh
  ./src/setup-vim.sh
  ./src/setup-tmux.sh
  ./src/setup-utils.sh
  ./src/setup-docker.sh
  ./src/setup-minishift.sh
  ./src/setup-config-files.sh

  echo ">>>>>> Things still need to be done <<<<<<<
  1. Open iTerm2. Goto Preferences > Profile > Default > Color > Load presets
  2. Choose the Dark Solarized theme or upload it if not present"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
