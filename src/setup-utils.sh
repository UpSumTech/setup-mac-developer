#!/usr/bin/env bash

install_pip_utils() {
  . $HOME/.bash_profile && pip install maybe \
    doitlive \
    percol \
    supervisor \
    csvkit \
    shyaml \
    cheat
}

install_tldr_for_bash() {
  curl -o $HOME/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr \
    && chmod +x $HOME/bin/tldr
}

install_ruby_utils() {
  gem install bundler \
    rake \
    thor \
    fpm \
    pleaserun
}

install_wiremock() {
  cd /home/developer/lib \
    && wget http://repo1.maven.org/maven2/com/github/tomakehurst/wiremock/1.57/wiremock-1.57-standalone.jar \
    && mv wiremock-1.57-standalone.jar wiremock.jar
}

install_node_utils() {
  npm install how2 \
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
    xml2json-command
}

install_go_utils() {
  go get -u github.com/tsenart/vegeta \
    github.com/msoap/shell2http \
    github.com/cortesi/modd/cmd/modd \
    github.com/jteeuwen/go-bindata/... \
    github.com/tylertreat/comcast
}

main() {
  install_pip_utils
  install_tldr_for_bash
  install_ruby_utils
  install_wiremock
  install_node_utils
  install_go_utils
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
