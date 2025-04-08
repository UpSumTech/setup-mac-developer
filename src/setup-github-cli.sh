#!/usr/bin/env bash

install_github_cli() {
  brew install gh
  gh auth login
  gh extension install github/gh-copilot
  gh extension upgrade gh-copilot
  gh extension install gennaro-tedesco/gh-f
  gh extension install dlvhdr/gh-dash
}

main() {
  install_github_cli
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
