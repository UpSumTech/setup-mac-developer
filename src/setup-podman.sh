#!/usr/bin/env bash

setup_podman() {
  podman machine init --cpus 1 --memory=1024
}

main() {
  setup_podman
  . "$HOME/.bashrc" && podman machine start
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
