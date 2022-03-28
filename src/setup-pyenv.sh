#!/usr/bin/env bash

pyenv_install_python() {
  local python_version="$1"

  PYENV_CFLAGS="-I$(brew --prefix openssl)/include"
  PYENV_CFLAGS="-I$(brew --prefix zlib)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix readline)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix sqlite)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix curl)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix bzip2)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix tcl-tk)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(xcrun --show-sdk-path)/usr/include $PYENV_CFLAGS"

  PYENV_LDFLAGS="-L$(brew --prefix openssl)/lib"
  PYENV_LDFLAGS="-L$(brew --prefix zlib)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix readline)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix sqlite)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix curl)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix bzip2)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix tcl-tk)/lib $PYENV_LDFLAGS"

  PYENV_PYTHON_CONFIGURE_OPTS="--enable-shared --enable-unicode=ucs2"
  env CPPFLAGS="$PYENV_CFLAGS" LDFLAGS="$PYENV_LDFLAGS" PYTHON_CONFIGURE_OPTS="$PYENV_PYTHON_CONFIGURE_OPTS" pyenv install -fk "$python_version"
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
  ln -s $HOME/.pyenv/versions/2.7.18/lib/libpython2.7.dylib
  ln -s $HOME/.pyenv/versions/3.10.3/lib/libpython3.10.dylib
  popd
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
