#!/usr/bin/env bash

main() {
  export email="$1"
  export name="$2"

  [[ -f ~/.bash_profile ]] && mv ~/.bash_profile ~/.bash_profile.bak
  ./src/xcode-and-essentials.sh
  ./src/setup-homebrew-and-packages.sh
  ./src/setup-bash.sh
  ./src/setup-git.sh "$name" "$email"
  ./src/setup-iterm2.sh
  ./src/setup-mysql.sh
  ./src/setup-postgres.sh
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
  ./src/setup-helm.sh
  ./src/setup-config-files.sh
  ./src/update-mac-limits.sh

  echo ">>>>>> Things still need to be done <<<<<<<
  1. Open iTerm2. Goto Preferences > Profile > Default > Color > Load presets
  2. Choose the Dark Solarized theme or upload it if not present
  3. When all done, reboot mac"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
