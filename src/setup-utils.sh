#!/usr/bin/env bash

install_kube_utils() {
  pushd .
  cd $HOME/tmp
  wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-darwin-amd64.tar.gz
  tar xf kubeval-darwin-amd64.tar.gz
  cp kubeval $HOME/bin
  popd
}

install_pip_utils() {
  pip --trusted-host pypi.python.org install doitlive \
    percol \
    supervisor \
    csvkit \
    shyaml \
    pylint \
    yq \
    pep8 \
    pycodestyle \
    pylama \
    pyflakes \
    yamllint \
    neovim \
    sexpdata \
    websocket-client

  pip3 --trusted-host pypi.python.org install \
    sexpdata \
    websocket-client
}

install_ruby_utils() {
  gem install bundler \
    rake \
    thor \
    fpm \
    pleaserun \
    sqlint \
    mdl \
    rubocop \
    rubocop-rails \
    ruby-lint \
    coderay \
    rouge
}

install_node_utils() {
  npm install -g how2 \
    cpy-cli \
    trash-cli \
    empty-trash-cli \
    strip-json-comments-cli \
    doctoc \
    git-commander \
    gistup \
    pretty-bytes-cli \
    normalize-newline-cli \
    speed-test \
    weather-cli \
    strip-css-comments-cli \
    localtunnel \
    json2csv \
    xml2json-command \
    json2yaml \
    js-beautify \
    jsonlint \
    jshint \
    js-yaml \
    iplocation-cli \
    eslint \
    babel-eslint \
    prettier \
    eslint-config-prettier \
    eslint-plugin-prettier \
    eslint-plugin-flowtype \
    eslint-plugin-react \
    stylelint \
    stylelint-scss \
    stylelint-processor-styled-components \
    stylelint-config-styled-components \
    stylelint-config-recommended-scss \
    stylelint-config-recommended \
    tldr
}

install_go_utils() {
  go get -u github.com/jteeuwen/go-bindata/...
  go get -u github.com/tylertreat/comcast
  go get -u github.com/fatih/hclfmt
  go get -u github.com/mitchellh/gox
  go get -u github.com/mitchellh/go-homedir
  go get -u mvdan.cc/interfacer
  go get -u github.com/jgautheron/goconst/cmd/goconst
  go get -u github.com/opennota/check/cmd/aligncheck
  go get -u github.com/opennota/check/cmd/structcheck
  go get -u github.com/opennota/check/cmd/varcheck
  go get -u github.com/mdempsky/maligned
  go get -u mvdan.cc/unparam
  go get -u github.com/stripe/safesql
  go get -u github.com/alexkohler/nakedret
  go get -u github.com/alecthomas/gometalinter
  go get -u github.com/nsf/gocode
  go get -u github.com/gordonklaus/ineffassign
  go get -u github.com/tsenart/deadcode
  go get -u github.com/fzipp/gocyclo
  go get -u github.com/mdempsky/unconvert
  go get -u github.com/securego/gosec/cmd/gosec
  go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
  go get -u github.com/alecthomas/gometalinter
  go get -u github.com/andrebq/gas
  go get -u honnef.co/go/tools/...
  go get -u github.com/zmb3/gogetdoc
  go get -u github.com/davidrjenni/reftools/cmd/fillstruct
  go get -u github.com/rogpeppe/godef
  go get -u github.com/fatih/motion
  go get -u github.com/kisielk/errcheck
  go get -u github.com/go-delve/delve/cmd/dlv
  go get -u github.com/koron/iferr
  go get -u github.com/klauspost/asmfmt/cmd/asmfmt
  go get -u github.com/josharian/impl
  go get -u github.com/jstemmer/gotags
  go get -u github.com/fatih/gomodifytags
  go get -u golang.org/x/lint/golint
  go get -u golang.org/x/tools/cmd/gorename
  go get -u golang.org/x/tools/cmd/guru
  go get -u golang.org/x/tools/cmd/goimports
  go get -u golang.org/x/tools/gopls
  go get -u github.com/motemen/gore/cmd/gore
  go get -u golang.org/x/tools/cmd/godoc
  go get -u mvdan.cc/sh/cmd/shfmt
  go get -u github.com/fatih/hclfmt
  go get -u github.com/fatih/motion
  # This is needed so that ruby bundle still keeps working
  # [[ -f $HOME/go/1.12beta1/bin/bundle ]] && mv $HOME/go/1.12beta1/bin/bundle $HOME/go/1.12beta1/bin/gobundle

  goenv rehash
}

install_other_utils() {
  wget https://github.com/kubernetes/kops/releases/download/1.9.2/kops-darwin-amd64
  chmod +x kops-darwin-amd64
  mv kops-darwin-amd64 $HOME/bin/kops
  . $HOME/.bash_profile && tfenv install
  . $HOME/.bash_profile && kopsenv install
  wget https://github.com/k14s/ytt/releases/download/v0.25.0/ytt-darwin-amd64
  chmod +x ytt-darwin-amd64
  mv ytt-darwin-amd64 $HOME/bin/ytt
  git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
}

install_dockerized_utils() {
  docker pull bridgecrew/checkov
}

install_cheat() {
  wget https://github.com/cheat/cheat/releases/download/3.2.1/cheat-darwin-amd64
  chmod +x cheat-darwin-amd64
  mv cheat-darwin-amd64 $HOME/bin/cheat
  mkdir -p $HOME/.config/cheat
  mkdir -p $HOME/share/doc/cheat/community
  mkdir -p $HOME/share/doc/cheat/personal
  mkdir -p $HOME/share/doc/cheat/work
  pushd .
  cd $HOME/share/doc/cheat
  git clone https://github.com/cheat/cheatsheets.git
  mv cheatsheets community
  popd
}

main() {
  install_kube_utils
  install_pip_utils
  install_ruby_utils
  install_node_utils
  install_go_utils
  install_other_utils
  install_cheat
  # install_dockerized_utils # This requires a GUI for the docker app to be started manually
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
