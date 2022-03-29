#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

main() {
  cp "$ROOT_DIR/templates/agignore" "$HOME/.agignore"
  cp "$ROOT_DIR/templates/inputrc" "$HOME/.inputrc"
  cp "$ROOT_DIR/templates/ctags" "$HOME/.ctags"
  cp "$ROOT_DIR/templates/tigrc" "$HOME/.tigrc"
  mkdir -p "$HOME/.config/cheat"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
