#!/usr/bin/env bash

install_homebrew() {
  /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

prep_homebrew() {
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
}

install_apps_from_cask() {
  brew cask install \
    java \
    java7 \
    google-drive \
    skype \
    viber \
    dropbox \
    slack \
    firefox \
    sublime \
    atom \
    google-chrome \
    google-chrome-canary \
    ngrok \
    virtualbox \
    vagrant \
    tcl \
    iterm2 \
    font-inconsolata \
    kindle \
    minikube
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
    python \
    ruby \
    node \
    golang \
    mysql \
    postgres \
    mongo \
    redis \
    rabbitmq \
    heroku-toolbelt \
    homebrew\/dupes\/ncurses \
    autoconf \
    automake \
    libtool \
    wget \
    htop \
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
    homebrew\/dupes\/diffutils \
    pyqt5 \
    maven \
    maven-shell \
    maven-completion \
    tig \
    python3 \
    lua@5.1 \
    luajit \
    perl \
    bash \
    autoenv \
    rbenv \
    jenv \
    pyenv \
    pyenv-virtualenv \
    nvm \
    awscli \
    tcptrace \
    iproute2mac \
    sysdig \
    mtr \
    jq \
    wireshark \
    mycli \
    pgcli \
    homebrew\/dupes\/krb5 \
    ansible \
    fio \
    docker \
    docker-compose \
    docker-machine \
    kubectl \
    spark \
    bash-completion \
    ctags \
    git-quick-stats \
    flock \
    ipcalc \
    nmap \
    iftop \
    nethogs \
    vnstat \
    multitail

  brew install homebrew\/dupes\/grep --with-default-names
  brew install nginx --with-passenger
  brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste
  brew install --HEAD universal-ctags
}

post_brew_package_installation() {
  mkdir -p "$HOME/lib"
  echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.bash_profile
  echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/sqlite/bin:/usr/local/opt/curl/bin:/usr/local/bin:$PATH"' >> $HOME/.bash_profile
  echo 'export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/findutils/libexec/gnuman:/usr/local/opt/gnu-tar/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"' >> $HOME/.bash_profile
  echo 'export PATH="/usr/local/opt/go/libexec/bin:$PATH"' >> $HOME/.bash_profile
  echo '. /usr/local/opt/autoenv/activate.sh' >> $HOME/.bash_profile
  echo 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"; fi' >> $HOME/.bash_profile
  [[ -x /usr/local/bin/nvm ]] || ln -s "/usr/local/opt/nvm" "/usr/local/bin/nvm"
  mkdir $HOME/.nvm
  echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bash_profile
  echo '. "/usr/local/opt/nvm/nvm.sh"' >> $HOME/.bash_profile
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
  echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
  echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> $HOME/.bash_profile
  echo 'eval "$(jenv init -)"' >> $HOME/.bash_profile
  mkdir -p $HOME/go/{pkg,bin,src}
  echo 'export GOPATH="$(go env GOPATH)"' >> $HOME/.bash_profile
  echo 'export PATH="$GOPATH/bin:$PATH"' >> $HOME/.bash_profile
  pip install --upgrade pip setuptools
  pip3 install --upgrade pip setuptools wheel
  git clone https://github.com/concordusapps/pyenv-implict.git $HOME/.pyenv/plugins/pyenv-implict
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
