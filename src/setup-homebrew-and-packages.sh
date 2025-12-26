#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

install_homebrew() {
  command -v brew || /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sudo chgrp -R admin /usr/local/*
  sudo chmod -R g+w /usr/local/*
  if [[ -d /opt/homebrew ]]; then
    sudo chgrp -R admin /opt/homebrew
    sudo chmod -R g+w /opt/homebrew
  fi
  # sudo chgrp -R admin /Library/Caches/Homebrew
  # sudo chmod -R g+w /Library/Caches/Homebrew
  if [[ -d /opt/homebrew-cask ]]; then
    sudo chgrp -R admin /opt/homebrew-cask
    sudo chmod -R g+w /opt/homebrew-cask
  fi
}

prep_homebrew() {
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  brew cleanup
  brew doctor
  brew upgrade
}

setup_brew_taps() {
  brew tap homebrew/cask-versions
  brew tap homebrew/services
  brew tap homebrew/cask-fonts
  brew tap universal-ctags/universal-ctags
  brew tap wata727/tflint
  brew tap mike-engel/jwt-cli
  brew tap mongodb/brew
  brew tap ktr0731/evans
  brew tap spring-io/tap
  brew tap kwilczynski/homebrew-pkenv
}

install_apps_from_cask() {
  # New mac os and the arm m1 chip have problems installing virtualbox because a hypervisor is not supported.
  # You need a fullon emulator like qemu
  # This might cause some pain to test out configuration using vagrant.
  # TODO : Add the link to address the issue with vagrant and arm m1 chip
  brew install openjdk@17
  sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
  brew install tcl-tk
  brew install font-inconsolata
  brew install iterm2
  echo "You might need to enable a few apps in >> System Preferences → Security & Privacy → General"
}

install_packages_from_brew() {
  brew install gcc
  brew install wget
  brew install zeromq
  brew install coreutils
  brew install findutils
  brew install gnu-tar
  brew install gnu-sed
  brew install gawk
  brew install gnutls
  brew install texinfo
  brew install gnu-indent
  brew install gnu-getopt
  brew install pgrep
  brew install ngrep
  brew install tree
  brew install pstree
  brew install glib
  brew install moreutils
  brew install cmake
  brew install cmake-docs
  brew install tmux
  brew install readline
  brew install openssl
  brew install git
  brew install git-gui
  brew install git-extras
  brew install git-secrets
  brew install mercurial
  brew install zlib
  brew install bzip2
  brew install bison
  brew install python
  brew install ruby
  brew install node
  brew install golang
  brew install mysql@8.0
  brew install postgresql@16
  brew install redis
  brew install rabbitmq
  brew install ncurses
  brew install autoconf
  brew install automake
  brew install libtool
  brew install pg_top
  brew install dnstop
  brew install iftop
  brew install ag
  brew install ack
  brew install diff-so-fancy
  brew install colordiff
  brew install diffutils
  brew install maven
  brew install maven-shell
  brew install maven-completion
  brew install tig
  brew install python3
  brew install lua
  brew install luarocks
  brew install bash
  brew install autoenv
  brew install rbenv
  brew install pyenv
  brew install pyenv-virtualenv
  brew install nvm
  brew install awscli
  brew install jq
  brew install mycli
  brew install pgcli
  brew install krb5
  brew install ansible
  brew install fio
  brew install podman # NOTE: This is the alternative for docker
  brew install kind
  brew install kubernetes-cli
  brew install bash-completion@2
  brew install yarn-completion
  brew install ruby-completion
  brew install rake-completion
  brew install git-quick-stats
  brew install ipcalc
  brew install nethogs
  brew install multitail
  brew install spring-boot
  brew install scala
  brew install sbt
  brew install tfenv
  brew install tflint
  brew install tgenv
  brew install pkenv
  brew install flyway
  brew install pipenv
  brew install shellcheck
  brew install checkbashisms
  brew install cppcheck
  brew install clang-format
  brew install watch
  brew install tcping
  brew install fzf
  brew install highlight
  brew install cscope
  brew install tmux-xpanes
  brew install jwt-cli
  brew install aspell
  brew install telnet
  brew install groovysdk
  brew install mongosh
  brew install graphviz
  brew install protobuf@21
  brew install istioctl
  brew install checkov
  brew install kubeconform
  brew tap johanhaleby/kubetail && brew install kubetail
  brew install grep
  brew install reattach-to-user-namespace # Verify that the latest version of mac OS can deal with this to copy paste buffers
  brew install goenv
  brew install curl
  brew install kreuzwerker/taps/m1-terraform-provider-helper # This is a helper for installing terraform modules for apple m1 mac
  brew install eksctl
  brew install sops
  brew install argocd
  brew install font-inconsolata-for-powerline
  brew install font-powerline-symbols
  brew install pulumi/tap/pulumi
  brew install kubebuilder
  brew install naml
  brew install cloudflared
  brew install cilium-cli
  brew install hubble
  brew install universal-ctags
  brew install luajit
  brew install ytt
  brew install kustomize
  brew install deno
  brew install uv
  brew install google-cloud-sdk
  brew install aichat
  brew install hadolint
  brew install markdownlint-cli
  brew install kubent
}

post_brew_package_installation() {
  [[ -x $(brew --prefix)/bin/nvm ]] || ln -sf "$(brew --prefix)/opt/nvm" "$(brew --prefix)/bin/nvm"
  mkdir -p "$HOME/.nvm"
  if [[ ! -d "$HOME/.pyenv/plugins/pyenv-implict" ]]; then
    git clone https://github.com/concordusapps/pyenv-implict.git "$HOME/.pyenv/plugins/pyenv-implict"
  fi
  cp "$ROOT_DIR/templates/bash_profile" "$HOME/.bash_profile"
  cp "$ROOT_DIR/templates/bashrc" "$HOME/.bashrc"
  cp "$ROOT_DIR/templates/gemini_config_file.json" "$HOME/.gemini_config_file.json"
  cp "$ROOT_DIR/templates/aider.conf.yaml" "$HOME/.aider.conf.yaml"
  brew cleanup
  brew services stop --all
}

main() {
  install_homebrew
  prep_homebrew
  setup_brew_taps
  install_apps_from_cask
  install_packages_from_brew
  post_brew_package_installation
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
