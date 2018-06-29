#!/usr/bin/env bash

install_pip_utils() {
  pip --trusted-host pypi.python.org install doitlive \
    percol \
    supervisor \
    csvkit \
    shyaml \
    cheat
}

install_ruby_utils() {
  gem install bundler \
    rake \
    thor \
    fpm \
    pleaserun
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
    jshint
}

install_go_utils() {
  go get -u github.com/jteeuwen/go-bindata/... \
    github.com/tylertreat/comcast \
    github.com/derekparker/delve/cmd/dlv \
    github.com/fatih/hclfmt \
    github.com/mitchellh/gox
}

main() {
  install_pip_utils
  install_ruby_utils
  install_node_utils
  install_go_utils
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
