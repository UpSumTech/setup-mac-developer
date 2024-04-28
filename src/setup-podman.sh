#!/usr/bin/env bash

setup_podman() {
  podman machine init --cpus 4 --memory=6144
}

main() {
  setup_podman
  . $HOME/.bash_profile && podman machine start
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
