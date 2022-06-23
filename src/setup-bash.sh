#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

change_shell() {
  local brewDir
  if [[ -d /usr/local/Cellar ]]; then
    brewDir="/usr/local"
  else
    brewDir="/opt/homebrew"
  fi
  if !sudo grep "$brewDir/bin/bash" /etc/shells; then
    sudo echo "$brewDir/bin/bash" >> /etc/shells
  fi
  chsh -s "$brewDir/bin/bash"
}

preserve_bash_profile() {
  mv $HOME/.bash_profile $HOME/.bash_profile.bak
}

install_bashit() {
  git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
  echo y > bash-it-install-option \
    && /bin/bash $HOME/.bash_it/install.sh < bash-it-install-option \
    && rm bash-it-install-option
}

add_composure() {
  pushd .
  cd $HOME/.bash_it/custom \
    && curl -L http://git.io/composure > composure.sh \
    && chmod +x composure.sh
  popd
}

create_custom_files() {
  touch $HOME/.bash_it/custom/aliases.bash
  touch $HOME/.bash_it/custom/utils.bash
  cp $ROOT_DIR/templates/bash_utils.sh $HOME/.bash_utils.sh
}

enable_bash_it_completions() {
  . "$HOME/.bash_it/bash_it.sh" && bash-it enable completion \
    awscli \
    brew \
    bundler \
    defaults \
    dirs \
    django \
    gem \
    git \
    grunt \
    gulp \
    maven \
    npm \
    packer \
    pip \
    pip3 \
    packer \
    ssh \
    terraform \
    vault \
    tmux \
    docker
}

enable_bash_it_plugins() {
  . "$HOME/.bash_it/bash_it.sh" && bash-it enable plugin \
    aws \
    dirs \
    extract \
    java \
    javascript \
    node \
    osx \
    python \
    ssh \
    tmux \
    man \
    fzf \
    postgres \
    explain \
    browser \
    docker
}

enable_bash_it_aliases() {
  . "$HOME/.bash_it/bash_it.sh" && bash-it enable alias \
    ag \
    ansible \
    bundler \
    docker \
    git \
    homebrew \
    homebrew-cask \
    maven \
    npm \
    osx \
    tmux \
    vim \
    emacs \
    docker \
    docker-compose
}

setup_bashit() {
  enable_bash_it_completions
  enable_bash_it_plugins
  enable_bash_it_aliases
}

restore_bash_profile() {
  mv $HOME/.bash_profile.bak $HOME/.bash_profile
}

main() {
  # change_shell
  preserve_bash_profile
  install_bashit
  add_composure
  create_custom_files
  setup_bashit
  restore_bash_profile
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
