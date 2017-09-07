#!/usr/bin/env bash

change_shell() {
  chsh -s usr/local/bin/bash
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
  cp templates/bash_utils.sh $HOME/.bash_utils.sh
}

enable_bash_it_completions() {
  . $HOME/.bash_profile && bash-it enable completion \
    awscli \
    brew \
    bundler \
    capistrano \
    defaults \
    dirs \
    django \
    gem \
    git \
    grunt \
    gulp \
    jboss7 \
    maven \
    npm \
    packer \
    pip \
    packer \
    ssh \
    terraform \
    test_kitchen \
    salt \
    tmux \
    vagrant \
    virtualbox \
    rake \
    docker \
    kubectl
}

enable_bash_it_plugins() {
  . $HOME/.bash_profile && bash-it enable plugin \
    aws \
    battery \
    dirs \
    extract \
    java \
    javascript \
    jenv \
    nginx \
    node \
    nvm \
    osx \
    projects \
    python \
    ssh \
    tmux
}

enable_bash_it_aliases() {
  . $HOME/.bash_profile && bash-it enable alias \
    ag \
    ansible \
    bundler \
    docker \
    git \
    heroku \
    homebrew \
    maven \
    npm \
    osx \
    rails \
    tmux \
    vagrant \
    vim
}

setup_bashit() {
  enable_bash_it_completions
  enable_bash_it_plugins
  enable_bash_it_aliases
}

update_bash_profile() {
  echo '[ -f ~/.bashrc ] && . ~/.bashrc' >> ~/.bash_profile
  echo 'export VISUAL=vim' >> ~/.bash_profile
  echo 'export EDITOR=$VISUAL' >> ~/.bash_profile
  echo 'export GIT_EDITOR=$EDITOR' >> ~/.bash_profile
  echo 'if [[ -f ~/.bash_utils.sh ]]; then source ~/.bash_utils.sh; load_docker_env; fi' >> ~/.bash_profile
}

main() {
  change_shell
  install_bashit
  add_composure
  create_custom_files
  setup_bashit
  update_bash_profile
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
