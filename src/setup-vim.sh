#!/usr/bin/env bash

VIM_SRC_DIR="$(mktemp -d "${TMPDIR}vim_src.XXXX")"
VIM_VERSION="8.0.0000"
trap "rm -rf "$VIM_SRC_DIR"" EXIT

get_vim() {
  wget "https://github.com/vim/vim/archive/v8.0.0000.tar.gz" -O "$VIM_SRC_DIR/vim.tar.gz"
}

build_vim_from_src() {
  pushd .
  cd "$VIM_SRC_DIR"
  tar xvzf vim.tar.gz && rm vim.tar.gz
  cd "vim-$VIM_VERSION"
  ./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-largefile \
    --disable-netbeans \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib/python2.7/config \
    --enable-perlinterp \
    --enable-luainterp \
    --with-lua-prefix="$(brew --prefix)" \
    --with-luajit \
    --enable-gui=auto \
    --enable-fail-if-missing \
    --with-tlib=ncurses \
    --enable-cscope
  make && make install
  popd
}

customize_vim() {
  curl -H "Cache-Control: no-cache" \
    -s \
    -S \
    -L \
    https://raw.githubusercontent.com/sumanmukherjee03/vim_setup/master/bootstrap.sh \
    | bash
  cd $HOME/.vim
  make
}

main() {
  get_vim
  build_vim_from_src
  customize_vim
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
