#!/usr/bin/env bash

install_helm() {
  brew install helm
  brew install helmsman
  brew install skaffold
}

enable_helm_plugins() {
  helm plugin install https://github.com/databus23/helm-diff
  helm plugin install https://github.com/adamreese/helm-nuke
  helm plugin install https://github.com/adamreese/helm-last
  helm plugin install https://github.com/aslafy-z/helm-git --version 0.10.0
  helm plugin install https://github.com/instrumenta/helm-kubeval
  helm plugin install https://github.com/karuppiah7890/helm-schema-gen.git # This plugin seems to fail when installing in mac m1
}

main() {
  install_helm
  . "$HOME/.bash_profile" && enable_helm_plugins
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
