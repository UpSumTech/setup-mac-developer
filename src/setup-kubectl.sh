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
    cert-manager \
    who-can
}

install_kube_convert() {
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$OS/$ARCH/kubectl-convert" &&
    chmod +x kubectl-convert &&
    mv kubectl-convert $HOME/bin/kubectl-convert
  )
}

main() {
  brew install kubectl
  install_krew_for_kubectl
  install_plugins_with_krew
  install_kube_convert
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
