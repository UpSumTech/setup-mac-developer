#!/usr/bin/env bash

install_krew_for_kubectl() {
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
}

install_plugins_with_krew() {
  . $HOME/.bash_profile
  kubectl krew install access-matrix \
    pod-logs \
    node-shell \
    who-can
}

main() {
  brew install kubectl
  install_krew_for_kubectl
  install_plugins_with_krew
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
