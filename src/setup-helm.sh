#!/usr/bin/env bash

enable_helm_plugins() {
  helm plugin install https://github.com/databus23/helm-diff
  helm plugin install https://github.com/adamreese/helm-nuke
  helm plugin install https://github.com/adamreese/helm-env
  helm plugin install https://github.com/adamreese/helm-last
  helm plugin install https://github.com/aslafy-z/helm-git --version 0.10.0
  helm plugin install https://github.com/instrumenta/helm-kubeval
  helm plugin install https://github.com/karuppiah7890/helm-schema-gen.git
}

main() {
  enable_helm_plugins
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
