#!/usr/bin/env bash

install_helmenv() {
  if [[ ! -d $HOME/.helmenv ]]; then
    git clone https://github.com/yuya-takeyama/helmenv.git $HOME/.helmenv
  fi
  echo "helmenv installed"
}

install_helm_versions() {
  local helm_version
  # local arr=( '3.8.0' '3.7.0' )
  local arr=( '3.7.0' )
  for helm_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && helmenv install "$helm_version"
  done
}

enable_helm_plugins() {
  helm plugin install https://github.com/databus23/helm-diff
  helm plugin install https://github.com/adamreese/helm-nuke
  helm plugin install https://github.com/adamreese/helm-last
  helm plugin install https://github.com/aslafy-z/helm-git --version 0.10.0
  helm plugin install https://github.com/instrumenta/helm-kubeval
  helm plugin install https://github.com/karuppiah7890/helm-schema-gen.git
}

main() {
  install_helmenv
  install_helm_versions
  . $HOME/.bash_profile && helmenv global 3.8.0
  echo '3.8.0' > "$HOME/.helm-version"
  . "$HOME/.bash_profile" && helmenv local 3.8.0 && enable_helm_plugins
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
