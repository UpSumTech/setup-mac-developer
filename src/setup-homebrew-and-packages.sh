#!/usr/bin/env bash

[[ ! -z "$BREW_APP_INSTALL_DIR" ]] || export BREW_APP_INSTALL_DIR="$HOME/Applications"
mkdir -p "$BREW_APP_INSTALL_DIR"

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

install_homebrew() {
  command -v brew || /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

prep_homebrew() {
  echo 'export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt:$PATH' >> $HOME/.bash_profile
  brew update
  brew cleanup
  brew cask cleanup
  brew doctor
}

setup_brew_taps() {
  brew tap caskroom\/versions
  brew tap homebrew\/services
  brew tap caskroom\/fonts
  brew tap brona\/iproute2mac
  brew tap universal-ctags\/universal-ctags
  brew tap discoteq\/discoteq
  brew tap msoap\/tools
  brew tap pivotal\/tap
  brew tap wata727\/tflint
  brew tap mike-engel\/jwt-cli
  brew tap adoptopenjdk\/openjdk
}

install_apps_from_cask() {
  # New mac os - high sierra may have trouble installing virtualbox
  # Follow this link to fix that - https://developer.apple.com/library/content/technotes/tn2459/_index.html
  # This could also be because the security ad privacy settings in mac is not allowing virttualbox to install stuff from oracle
  # Allowing that could fix the problem too
  command -v virtualbox || brew cask install --appdir="$BREW_APP_INSTALL_DIR" virtualbox
  brew cask install --appdir="$BREW_APP_INSTALL_DIR" \
    java \
    adoptopenjdk8 \
    adoptopenjdk9 \
    adoptopenjdk10 \
    adoptopenjdk11 \
    adoptopenjdk12 \
    atom \
    vagrant \
    tcl \
    font-inconsolata \
    kindle \
    minikube \
    minishift \
    caffeine
}

install_packages_from_brew() {
  brew install \
    gcc \
    curl \
    zeromq \
    coreutils \
    findutils \
    gnu-tar \
    gnu-sed \
    gawk \
    gnutls \
    gnu-indent \
    gnu-getopt \
    pgrep \
    ngrep \
    sgrep \
    tree \
    pstree \
    moreutils \
    cmake \
    tmux \
    readline \
    openssl \
    git \
    git-extras \
    mercurial \
    zlib \
    python \
    ruby \
    node \
    golang \
    mysql@5.7 \
    postgresql@10 \
    redis \
    rabbitmq \
    ncurses \
    autoconf \
    automake \
    libtool \
    mytop \
    pg_top \
    dnstop \
    passenger \
    iftop \
    imagemagick \
    ag \
    ack \
    diff-so-fancy \
    colordiff \
    diffutils \
    maven \
    maven-shell \
    maven-completion \
    tig \
    python3 \
    lua@5.1 \
    luajit \
    bash \
    autoenv \
    rbenv \
    jenv \
    goenv \
    pyenv \
    pyenv-virtualenv \
    nvm \
    awscli \
    tcptrace \
    iproute2mac \
    mtr \
    jq \
    mycli \
    pgcli \
    krb5 \
    ansible \
    fio \
    docker \
    container-diff \
    docker-machine \
    kubectl \
    kubectx \
    spark \
    bash-completion@2 \
    git-quick-stats \
    flock \
    ipcalc \
    nmap \
    iftop \
    nethogs \
    vnstat \
    multitail \
    modd \
    shell2http \
    vegeta \
    springboot \
    dep \
    magic-wormhole \
    scala \
    terraform \
    tfenv \
    tflint \
    flyway \
    pipenv \
    shellcheck \
    checkbashisms \
    cppcheck \
    clang-format \
    watch \
    tcping \
    fzf \
    highlight \
    cscope \
    luarocks \
    tmux-xpanes \
    jwt-cli \
    aspell \
    telnet \
    groovysdk

  brew install grep
  brew install nginx passenger
  brew install reattach-to-user-namespace # Verify that the latest version of mac OS can deal with this to copy paste buffers
  brew install --HEAD universal-ctags
}

install_extras_from_brew() {
  brew cask install --appdir="$BREW_APP_INSTALL_DIR" iterm2
}

post_brew_package_installation() {
  git clone https://github.com/kilna/kopsenv.git $HOME/.kopsenv
  chmod +x $HOME/.kopsenv/bin/*
  chmod +x $HOME/.kopsenv/libexec/*
  echo '0.12.0' > $HOME/.terraform-version
  echo '1.12.0' > $HOME/.kops-version
  [[ -x $(brew --prefix)/bin/nvm ]] || ln -s "$(brew --prefix)/opt/nvm" "$(brew --prefix)/bin/nvm"
  mkdir -p $HOME/.nvm
  [[ -d $HOME/.pyenv/plugins/pyenv-implict ]] \
    || git clone https://github.com/concordusapps/pyenv-implict.git $HOME/.pyenv/plugins/pyenv-implict
  cp "$ROOT_DIR/templates/bash_profile" "$HOME/.bash_profile"
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
