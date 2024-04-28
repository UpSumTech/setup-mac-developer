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
    defaults \
    dirs \
    git \
    ssh \
    tmux
}

enable_bash_it_plugins() {
  . "$HOME/.bash_it/bash_it.sh" && bash-it enable plugin \
    aws \
    dirs \
    extract \
    osx \
    ssh \
    tmux \
    man \
    fzf \
    explain
}

setup_bashit() {
  enable_bash_it_completions
  enable_bash_it_plugins
}

restore_bash_profile() {
  mv $HOME/.bash_profile.bak $HOME/.bash_profile
}

main() {
  change_shell # NOTE : You might want to do this part manually in some work machines if needed
  preserve_bash_profile
  install_bashit
  add_composure
  create_custom_files
  setup_bashit
  restore_bash_profile
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
