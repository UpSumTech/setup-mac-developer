#!/usr/bin/env bash

THIS_DIR="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
ROOT_DIR="$THIS_DIR/.."
VIM_SRC_DIR="$(mktemp -d "${TMPDIR}vim_src.XXXX")"
PYTHON_VERSION="2.7.18"
PYTHON3_VERSION="3.10.3"
PYTHON_VERSION_SHORT="2.7"
PYTHON3_VERSION_SHORT="3.10"
trap "rm -rf "$VIM_SRC_DIR"" EXIT

export PID="$$" # Get parent pid so that you can kill the main proc from subshells
die() {
  echo >&2 "Error : $*"
  kill -s TERM $PID
  exit 1
}

wrap_around_dir_change() {
  local fn="$1"
  shift 1
  pushd .
  hash -r # rehash bash executables
  eval "$(declare -F "$fn")" "$@"
  popd
}

verify_required_python_versions() {
  command -v python | grep "pyenv" || die "python needs to be installed through pyenv"
  pyenv versions | grep $PYTHON_VERSION || die "Does not have python version $PYTHON_VERSION installed through pyenv"
  pyenv versions | grep $PYTHON3_VERSION || die "Does not have python version $PYTHON3_VERSION installed through pyenv"
}

get_vim() {
  cd "$VIM_SRC_DIR"
  git clone https://github.com/vim/vim.git
}

build_vim_from_src() {
  . "$HOME/.bash_profile"
  pyenv local "$PYTHON_VERSION" "$PYTHON3_VERSION"
  local py_config="$(pyenv prefix $PYTHON_VERSION/lib/python2.7/config)"
  local py3_prefix="$(pyenv prefix $PYTHON3_VERSION)"
  local py3_config="$(${py3_prefix}/bin/python-config --configdir)"
  echo ">>>> PYTHON_CONFIG : $py_config"
  echo ">>>> PYTHON3_CONFIG : $py3_config"
  cd "$VIM_SRC_DIR/vim"
  make clean distclean
  ./configure \
    --with-features=huge \
    --with-local-dir="$(brew --prefix)" \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-largefile \
    --disable-netbeans \
    --enable-pythoninterp \
    --with-python-command="python${PYTHON_VERSION_SHORT}" \
    --with-python-config-dir="$py_config" \
    --enable-python3interp=dynamic \
    --with-python3-command="python${PYTHON3_VERSION_SHORT}" \
    --with-python3-config-dir=$py3_config \
    --enable-perlinterp \
    --enable-tclinterp \
    --enable-luainterp \
    --with-lua-prefix="$(brew --prefix)" \
    --with-luajit \
    --enable-gui=auto \
    --enable-fail-if-missing \
    --with-tlib=ncurses \
    --enable-cscope \
    --prefix=$HOME
  make && make install
  pyenv local --unset
}

customize_vim() {
  . "$HOME/.bash_profile"
  curl -H "Cache-Control: no-cache" -sSL https://raw.githubusercontent.com/sumanmukherjee03/vim_setup/master/bootstrap.sh | bash
  cd $HOME/.vim
  make
}

main() {
  verify_required_python_versions
  get_vim
  wrap_around_dir_change build_vim_from_src
  customize_vim
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
