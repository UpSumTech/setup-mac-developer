#!/usr/bin/env bash

change_shell() {
  chsh -s usr/local/bin/bash
  [[ -f /bin/old_bash ]] || sudo mv /bin/bash /bin/old_bash
  sudo ln -f /usr/local/bin/bash /bin/bash
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
    pip3 \
    packer \
    ssh \
    terraform \
    vault \
    test_kitchen \
    salt \
    tmux \
    vagrant \
    virtualbox \
    rake \
    docker
}

enable_bash_it_plugins() {
  . $HOME/.bash_profile && bash-it enable plugin \
    aws \
    dirs \
    extract \
    java \
    javascript \
    nginx \
    node \
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
    homebrew-cask \
    maven \
    npm \
    osx \
    rails \
    tmux \
    vagrant \
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

update_bash_profile() {
  echo '[ -f ~/.bashrc ] && . ~/.bashrc' >> ~/.bash_profile
  echo 'export VISUAL=vim' >> ~/.bash_profile
  echo 'export EDITOR=$VISUAL' >> ~/.bash_profile
  echo 'export GIT_EDITOR=$EDITOR' >> ~/.bash_profile
  cat $HOME/.bash_profile.bak >> $HOME/.bash_profile
}

main() {
  change_shell
  preserve_bash_profile
  install_bashit
  add_composure
  create_custom_files
  setup_bashit
  update_bash_profile
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
