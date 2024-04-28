#!/usr/bin/env bash

pyenv_install_python() {
  local python_version="$1"
  PYENV_PYTHON_CONFIGURE_OPTS="--enable-shared --enable-unicode=ucs2 --build=aarch64-apple-darwin$(uname -r)"
  env CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" PYTHON_CONFIGURE_OPTS="$PYENV_PYTHON_CONFIGURE_OPTS" pyenv install -fk "$python_version"
}

install_pythons() {
  local arr=('2.7.18' \
    '3.10.3' \
  )

  local python_version
  . "$HOME/.bash_profile"
  for python_version in "${arr[@]}"; do
    pyenv_install_python $python_version
  done
}

main() {
  install_pythons
  . $HOME/.bash_profile && pyenv global 2.7.18 3.10.3
  pushd .
  mkdir -p $HOME/lib
  cd $HOME/lib
  ln -sf $HOME/.pyenv/versions/2.7.18/lib/libpython2.7.dylib
  ln -sf $HOME/.pyenv/versions/3.10.3/lib/libpython3.10.dylib
  popd
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
