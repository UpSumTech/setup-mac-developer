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

upgrade_pip() {
  pip install --upgrade pip
}

setup_python_shared_libs() {
  local version
  local python_versions=( \
    '2.7.10' \
    '2.7.11' \
    '2.7.12' \
    '2.7.14' \
    '3.4.4' \
  )
  for version in ${python_versions[@]}; do
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -fk ""
  done
  pushd .
  mkdir -p $HOME/lib
  cd $HOME/lib
  ln -sf $HOME/.pyenv/versions/2.7.14/lib/libpython2.7.dylib
  ln -sf $HOME/.pyenv/versions/3.4.4/lib/libpython3.4m.dylib
  popd
  pyenv rehash
}

main() {
  install_virtualenv_and_virtualenvwrapper
  setup_bashrc
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
