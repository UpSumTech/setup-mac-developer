#!/usr/bin/env bash

install_virtualenv_and_virtualenvwrapper() {
  pip install virtualenv
  pip install virtualenvwrapper
}

setup_bashrc() {
  echo '[ -d ~/.virtualenv ] || mkdir ~/.virtualenv' >> $HOME/.bash_profile
  echo 'export WORKON_HOME=~/.virtualenv' >> $HOME/.bash_profile
  echo '[ -s /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh' >> $HOME/.bash_profile
}

main() {
  install_virtualenv_and_virtualenvwrapper
  setup_bashrc
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
