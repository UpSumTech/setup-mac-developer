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
  brew tap homebrew\/cask-versions
  brew tap homebrew\/services
  brew tap homebrew\/cask-fonts
  brew tap brona\/iproute2mac
  brew tap universal-ctags\/universal-ctags
  brew tap discoteq\/discoteq
  brew tap msoap\/tools
  brew tap pivotal\/tap
  brew tap wata727\/tflint
  brew tap mike-engel\/jwt-cli
  brew tap adoptopenjdk\/openjdk
  brew tap filippo.io\/age https:\/\/filippo.io\/age
  brew tap mongodb\/brew
  brew tap ktr0731\/evans
  brew tap spring-io\/tap
  brew tap kwilczynski\/homebrew-pkenv
}

install_apps_from_cask() {
  # New mac os and the arm m1 chip have problems installing virtualbox because a hypervisor is not supported.
  # You need a fullon emulator like qemu
  # This might cause some pain to test out configuration using vagrant.
  # TODO : Add the link to address the issue with vagrant and arm m1 chip
  brew install java
  brew install adoptopenjdk\/openjdk\/adoptopenjdk8
  brew install adoptopenjdk9
  brew install adoptopenjdk10
  brew install adoptopenjdk11
  brew install adoptopenjdk12
  brew install atom
  brew install vagrant
  brew install tcl-tk
  brew install font-inconsolata
  brew install docker
  brew install minikube
  brew install caffeine
  brew install macfuse
  brew install intellij-idea-ce
  brew install eva
  brew install brave-browser
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
  brew install gnu-indent
  brew install gnu-getopt
  brew install pgrep
  brew install ngrep
  brew install tree
  brew install pstree
  brew install moreutils
  brew install cmake
  brew install tmux
  brew install readline
  brew install openssl
  brew install git
  brew install git-extras
  brew install mercurial
  brew install zlib
  brew install bzip2
  brew install python
  brew install ruby
  brew install node
  brew install golang
  brew install mysql@5.7
  brew install postgresql@10
  brew install redis
  brew install rabbitmq
  brew install ncurses
  brew install autoconf
  brew install automake
  brew install libtool
  brew install mytop
  brew install pg_top
  brew install dnstop
  brew install passenger
  brew install iftop
  brew install imagemagick
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
  brew install lua@5.1
  brew install bash
  brew install autoenv
  brew install rbenv
  brew install jenv
  brew install pyenv
  brew install pyenv-virtualenv
  brew install nvm
  brew install awscli
  brew install tcptrace
  brew install iproute2mac
  brew install mtr
  brew install jq
  brew install mycli
  brew install pgcli
  brew install krb5
  brew install ansible
  brew install fio
  brew install docker
  brew install container-diff
  brew install kubectl
  brew install kubectx
  brew install kops
  brew install spark
  brew install bash-completion@2
  brew install git-quick-stats
  brew install flock
  brew install ipcalc
  brew install nmap
  brew install iftop
  brew install nethogs
  brew install vnstat
  brew install multitail
  brew install modd
  brew install shell2http
  brew install vegeta
  brew install spring-boot
  brew install magic-wormhole
  brew install scala
  brew install tfenv
  brew install tflint
  brew install tgenv
  brew install pkenv
  brew install packer-completion
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
  brew install luarocks
  brew install tmux-xpanes
  brew install jwt-cli
  brew install aspell
  brew install telnet
  brew install groovysdk
  brew install age
  brew install ffsend
  brew install mongodb-community-shell
  brew install graphviz
  brew install todo-txt
  brew install protobuf
  brew install mailhog
  brew install istioctl
  brew install checkov
  brew install kubeconform
  brew tap johanhaleby/kubetail && brew install kubetail
  brew install mas # This is useful for installing apps from the app store
  brew install grep
  brew install reattach-to-user-namespace # Verify that the latest version of mac OS can deal with this to copy paste buffers
  brew install --HEAD goenv
  brew install curl
  brew install nginx passenger
  brew install --HEAD universal-ctags
  brew install luajit --HEAD # This does not seem to be installing properly on mac ARM M1 by default. Hence this workaround.
}

post_brew_package_installation() {
  [[ -x $(brew --prefix)/bin/nvm ]] || ln -s "$(brew --prefix)/opt/nvm" "$(brew --prefix)/bin/nvm"
  mkdir -p $HOME/.nvm
  if [[ ! -d $HOME/.pyenv/plugins/pyenv-implict ]]; then
    git clone https://github.com/concordusapps/pyenv-implict.git $HOME/.pyenv/plugins/pyenv-implict
  fi
  cp "$ROOT_DIR/templates/bash_profile" "$HOME/.bash_profile"
  mkdir -p $HOME/.puppetlabs/wash
  cp "$ROOT_DIR/templates/wash_analytics.yml" "$HOME/.puppetlabs/wash/analytics.yml"
  cp "$ROOT_DIR/templates/wash.yml" "$HOME/.puppetlabs/wash/wash.yml"
  mkdir -p $HOME/.todo
  cp "$ROOT_DIR/templates/todo.cfg" "$HOME/.todo/config"
  if [[ -d /opt/homebrew ]]; then
    git -C /opt/homebrew/Library/Taps/homebrew/homebrew-core fetch
    git -C /opt/homebrew/Library/Taps/homebrew/homebrew-cask fetch
  else
    git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch
    git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask fetch
  fi
  brew update
  brew cleanup
  brew doctor
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
