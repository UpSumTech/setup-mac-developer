#!/usr/bin/env bash

install_rustup() {
  # This will add a line to the ~/.bash_profile file : `source $HOME/.cargo/env`
  # That line is already added by to bash_profile, so this will just add it a second time.
  # That's why we remove the last line after the installation
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  if cat "$HOME/.bash_profile" | tail -n 1 | grep -i cargo; then
    head -n -1 "$HOME/.bash_profile" | sponge "$HOME/.bash_profile"
  fi
  rustup completions bash > $(brew --prefix)/etc/bash_completion.d/rustup.bash-completion
  rustup component add rust-src # Add component for rust-src because you will need it in the LSP for vim that rust uses
}

main() {
  install_rustup # For uninstall `rustup self uninstall`
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
