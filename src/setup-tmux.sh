#!/usr/bin/env bash

main() {
  local tmpdir="$(mktemp -d "$TMPDIR/tmux_setup.XXXX")"
  cd "$tmpdir"
  [[ -d "$HOME/.tmux" ]] && rm -rf "$HOME/.tmux"
  git clone https://github.com/UpSumTech/tmux_setup.git
  cd tmux_setup
  cat bootstrap.sh | sed -e 's#git@github.com:UpSumTech/tmux_setup.git#https://github.com/UpSumTech/tmux_setup#g;' | /usr/bin/env bash
  cd ~
  rm -rf "$tmpdir"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
