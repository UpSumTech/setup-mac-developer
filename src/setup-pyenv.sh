#!/usr/bin/env bash

install_pythons() {
  local python_version
  local arr=('2.7.14' \
    '3.4.4' \
  )
  for python_version in "${arr[@]}"; do
    . "$HOME/.bash_profile" && env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -fk "$python_version"
  done
}

main() {
  install_pythons
  . $HOME/.bash_profile && pyenv global 2.7.14 3.4.4
  pushd .
  mkdir -p $HOME/lib
  cd $HOME/lib
  ln -s $HOME/.pyenv/versions/2.7.14/lib/libpython2.7.dylib
  ln -s $HOME/.pyenv/versions/3.4.4/lib/libpython3.4m.dylib
  popd
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
