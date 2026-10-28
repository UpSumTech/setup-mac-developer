#!/usr/bin/env bash

pyenv_install_python() {
  local python_version="$1"
  PYENV_PYTHON_CONFIGURE_OPTS="--enable-shared --enable-unicode=ucs2 --build=aarch64-apple-darwin$(uname -r)"
  env CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" PYTHON_CONFIGURE_OPTS="$PYENV_PYTHON_CONFIGURE_OPTS" pyenv install -fk "$python_version"
}

install_pythons() {
  local arr=( '3.13.18' '3.12.16' )

  local python_version
  . "$HOME/.bashrc"
  for python_version in "${arr[@]}"; do
    pyenv_install_python "$python_version"
  done
}

main() {
  install_pythons
  . "$HOME/.bashrc" && pyenv global 3.13.18
  mkdir -p "$HOME/lib"
  ln -sf "$HOME/.pyenv/versions/3.12.16/lib/libpython3.12.dylib" "$HOME/lib/libpython3.12.dylib"
  ln -sf "$HOME/.pyenv/versions/3.13.18/lib/libpython3.13.dylib" "$HOME/lib/libpython3.13.dylib"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
