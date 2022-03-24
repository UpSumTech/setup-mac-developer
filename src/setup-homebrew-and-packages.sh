#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

install_homebrew() {
  command -v brew || /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sudo chgrp -R admin /usr/local/*
  sudo chmod -R g+w /usr/local/*
  # sudo chgrp -R admin /Library/Caches/Homebrew
  # sudo chmod -R g+w /Library/Caches/Homebrew
  # sudo chgrp -R admin /opt/homebrew-cask
  # sudo chmod -R g+w /opt/homebrew-cask
}

prep_homebrew() {
  echo 'export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt:$PATH' >> $HOME/.bash_profile
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
}

install_apps_from_cask() {
  # New mac os - high sierra may have trouble installing virtualbox
  # Follow this link to fix that - https://developer.apple.com/library/content/technotes/tn2459/_index.html
  # This could also be because the security ad privacy settings in mac is not allowing virttualbox to install stuff from oracle
  # Allowing that could fix the problem too
  command -v virtualbox || brew install virtualbox
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
  brew install kindle
  brew install docker
  brew install minikube
  brew install caffeine
  brew install macfuse
  brew install intellij-idea-ce
  brew install eva
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
  brew install sgrep
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
  brew install luajit
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
  brew install packer
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
  brew install puppetlabs/puppet/wash
  brew install mongodb-community-shell
  brew install graphviz
  brew install todo-txt
  brew install protobuf
  brew install helm
  brew install helmsman
  brew install mailhog
  brew install istioctl
  brew install grep
  brew install reattach-to-user-namespace # Verify that the latest version of mac OS can deal with this to copy paste buffers
  brew install --HEAD goenv
  brew install curl
  brew install nginx passenger
  brew install --HEAD universal-ctags
}

install_extras_from_brew() {
  brew install iterm2
}

post_brew_package_installation() {
  git clone https://github.com/kilna/kopsenv.git $HOME/.kopsenv
  chmod +x $HOME/.kopsenv/bin/*
  chmod +x $HOME/.kopsenv/libexec/*
  echo '1.23.0' > $HOME/.kops-version
  [[ -x $(brew --prefix)/bin/nvm ]] || ln -s "$(brew --prefix)/opt/nvm" "$(brew --prefix)/bin/nvm"
  mkdir -p $HOME/.nvm
  [[ -d $HOME/.pyenv/plugins/pyenv-implict ]] \
    || git clone https://github.com/concordusapps/pyenv-implict.git $HOME/.pyenv/plugins/pyenv-implict
  cp "$ROOT_DIR/templates/bash_profile" "$HOME/.bash_profile"
  mkdir -p $HOME/.puppetlabs/wash
  cp "$ROOT_DIR/templates/wash_analytics.yml" "$HOME/.puppetlabs/wash/analytics.yml"
  cp "$ROOT_DIR/templates/wash.yml" "$HOME/.puppetlabs/wash/wash.yml"
  mkdir -p $HOME/.todo
  cp "$ROOT_DIR/templates/todo.cfg" "$HOME/.todo/config"
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask fetch
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
  install_extras_from_brew
  post_brew_package_installation
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
