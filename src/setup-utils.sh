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
    stylelint-config-recommended
}

install_go_utils() {
  go get -u github.com/jteeuwen/go-bindata/... \
    github.com/tylertreat/comcast \
    github.com/derekparker/delve/cmd/dlv \
    github.com/fatih/hclfmt \
    github.com/mitchellh/gox \
    mvdan.cc/interfacer \
    github.com/jgautheron/goconst/cmd/goconst \
    github.com/opennota/check/cmd/aligncheck \
    github.com/opennota/check/cmd/structcheck \
    github.com/opennota/check/cmd/varcheck \
    github.com/mdempsky/maligned \
    mvdan.cc/unparam \
    github.com/stripe/safesql \
    github.com/alexkohler/nakedret \
    honnef.co/go/tools/cmd/unused \
    github.com/alecthomas/gometalinter \
    github.com/nsf/gocode \
    golang.org/x/tools/cmd/godoc \
    github.com/motemen/gore/cmd/gore \
    github.com/gordonklaus/ineffassign \
    github.com/tsenart/deadcode \
    github.com/fzipp/gocyclo \
    github.com/mdempsky/unconvert \
    github.com/securego/gosec/cmd/gosec \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/alecthomas/gometalinter \
    github.com/andrebq/gas \
    honnef.co/go/tools/...

    # mvdan.cc/sh/cmd/shfmt - This works with the latest versions of go 1.11 and more
}

install_other_utils() {
  wget https://github.com/kubernetes/kops/releases/download/1.9.2/kops-darwin-amd64
  chmod +x kops-darwin-amd64
  mv kops-darwin-amd64 $HOME/bin/kops
  . $HOME/.bash_profile && tfenv install
  . $HOME/.bash_profile && kopsenv install
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
