#!/usr/bin/env bash

install_kubectl() {
  (
    cd "$(mktemp -d)" &&
    VERSION="v1.32.9" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -fsSLO "https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl" &&
    curl -fsSLO "https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl.sha256" &&
    chmod +x kubectl &&
    echo "$(cat kubectl.sha256)  kubectl" | shasum -a 256 --check &&
    mv kubectl "$HOME/bin/kubectl"
  )
}

install_krew_for_kubectl() {
  (
    cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
}

install_plugins_with_krew() {
  . "$HOME/.bashrc"
  kubectl krew install access-matrix \
    ctx \
    ns \
    pv-migrate \
    explore \
    access-matrix \
    kyverno \
    node-shell \
    pod-logs \
    node-shell \
    cert-manager \
    who-can \
    mounts
}

install_kube_convert() {
  (
    cd "$(mktemp -d)" &&
    VERSION="v1.32.9" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -LO "https://dl.k8s.io/release/${VERSION}/bin/$OS/$ARCH/kubectl-convert" &&
    curl -LO "https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl-convert.sha256" &&
    chmod +x kubectl-convert &&
    echo "$(cat kubectl-convert.sha256)  kubectl-convert" | shasum -a 256 --check &&
    mv kubectl-convert "$HOME/bin/kubectl-convert"
  )
}

install_popeye() {
  (
    cd "$(mktemp -d)" &&
    VERSION="v0.22.1" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -fsSLO "https://github.com/derailed/popeye/releases/download/${VERSION}/popeye_${OS}_${ARCH}.tar.gz"
    tar zxvf "popeye_${OS}_${ARCH}.tar.gz" &&
    chmod +x popeye &&
    mv popeye "$HOME/bin/popeye"
  )
}

main() {
  install_kubectl
  install_krew_for_kubectl
  install_plugins_with_krew
  install_popeye
  install_kube_convert
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
