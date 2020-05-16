#!/usr/bin/env bash

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
  go get -u github.com/jteeuwen/go-bindata/... \
    github.com/tylertreat/comcast \
    github.com/fatih/hclfmt \
    github.com/mitchellh/gox \
    github.com/mitchellh/go-homedir \
    mvdan.cc/interfacer \
    github.com/jgautheron/goconst/cmd/goconst \
    github.com/opennota/check/cmd/aligncheck \
    github.com/opennota/check/cmd/structcheck \
    github.com/opennota/check/cmd/varcheck \
    github.com/mdempsky/maligned \
    mvdan.cc/unparam \
    github.com/stripe/safesql \
    github.com/alexkohler/nakedret \
    github.com/alecthomas/gometalinter \
    github.com/nsf/gocode \
    github.com/gordonklaus/ineffassign \
    github.com/tsenart/deadcode \
    github.com/fzipp/gocyclo \
    github.com/mdempsky/unconvert \
    github.com/securego/gosec/cmd/gosec \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/alecthomas/gometalinter \
    github.com/andrebq/gas \
    honnef.co/go/tools/... \
    github.com/zmb3/gogetdoc \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/rogpeppe/godef \
    github.com/fatih/motion \
    github.com/kisielk/errcheck \
    github.com/go-delve/delve/cmd/dlv \
    github.com/koron/iferr \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/josharian/impl \
    github.com/jstemmer/gotags \
    github.com/fatih/gomodifytags \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/tools/gopls \
    github.com/motemen/gore/cmd/gore \
    golang.org/x/tools/cmd/godoc \
    mvdan.cc/sh/cmd/shfmt \
    github.com/fatih/hclfmt \
    github.com/fatih/gomodifytags
    # golang.org/x/tools/gotags - This one didnt work with 1.12beta1

  # This is needed so that ruby bundle still keeps working
  [[ -f $HOME/go/bin/bundle ]] && mv $HOME/go/bin/bundle $HOME/go/bin/gobundle
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
  install_pip_utils
  install_ruby_utils
  install_node_utils
  install_go_utils
  install_other_utils
  install_cheat
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
