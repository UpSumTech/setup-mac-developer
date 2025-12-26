#! /usr/bin/env bash

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

install_pip_utils() {
  # Add pyright because you need it as the LSP for claude code
  python3 -m pip --trusted-host pypi.python.org install doitlive \
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
    websocket-client \
    pyright
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
  npm install -g prettier \
    stylelint \
    stylelint-scss \
    eslint \
    typescript-language-server \
    typescript \
    anthropic-ai/claude-code
}

install_go_utils() {
  go install github.com/jteeuwen/go-bindata/...@latest
  go install github.com/tylertreat/comcast@latest
  go install github.com/fatih/hclfmt@latest
  go install github.com/mitchellh/gox@latest
  go install github.com/mitchellh/go-homedir@latest
  go install mvdan.cc/interfacer@latest
  go install github.com/jgautheron/goconst/cmd/goconst@latest
  go install github.com/opennota/check/cmd/aligncheck@latest
  go install github.com/opennota/check/cmd/structcheck@latest
  go install github.com/opennota/check/cmd/varcheck@latest
  go install github.com/mdempsky/maligned@latest
  go install mvdan.cc/unparam@latest
  go install github.com/stripe/safesql@latest
  go install github.com/alexkohler/nakedret@latest
  go install github.com/nsf/gocode@latest
  go install github.com/gordonklaus/ineffassign@latest
  go install github.com/tsenart/deadcode@latest
  go install github.com/fzipp/gocyclo@latest
  go install github.com/mdempsky/unconvert@latest
  go install github.com/securego/gosec/cmd/gosec@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install github.com/andrebq/gas@latest
  go install honnef.co/go/tools/...@latest
  go install github.com/zmb3/gogetdoc@latest
  go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
  go install github.com/rogpeppe/godef@latest
  go install github.com/fatih/motion@latest
  go install github.com/kisielk/errcheck@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install github.com/koron/iferr@latest
  go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
  go install github.com/josharian/impl@latest
  go install github.com/jstemmer/gotags@latest
  go install github.com/fatih/gomodifytags@latest
  go install golang.org/x/lint/golint@latest
  go install golang.org/x/tools/cmd/gorename@latest
  go install golang.org/x/tools/cmd/guru@latest
  go install golang.org/x/tools/cmd/goimports@latest
  go install golang.org/x/tools/gopls@latest
  go install golang.org/x/tools/cmd/godoc@latest
  go install mvdan.cc/sh/cmd/shfmt@latest
  go install github.com/fatih/hclfmt@latest
  go install github.com/fatih/motion@latest
  go install github.com/golang/protobuf/proto@latest
  go install github.com/golang/protobuf/protoc-gen-go@latest
  go install golang.org/x/tools/gopls@latest
  go install github.com/reugn/gemini-cli/cmd/gemini@latest
  goenv rehash
}

install_cheat() {
  go install github.com/cheat/cheat/cmd/cheat@latest
  mkdir -p "$HOME/.config/cheat"
  cp "$ROOT_DIR/templates/cheatconf.yml" "$HOME/.config/cheat/conf.yml"
  mkdir -p "$HOME/share/doc/cheat/personal"
  mkdir -p "$HOME/share/doc/cheat/work"
  wget -O "$HOME/bin/cheatsheets" https://raw.githubusercontent.com/cheat/cheat/master/scripts/git/cheatsheets
  chmod +x "$HOME/bin/cheatsheets"
  pushd .
  cd "$HOME/share/doc/cheat"
  rm -rf community || echo "no previous community cheatsheets existed"
  rm -rf cheatsheets || echo "no previous community cheatsheets existed"
  git clone https://github.com/cheat/cheatsheets.git
  mv cheatsheets community
  popd
  . "$HOME/.bashrc" && cheatsheets pull
}

main() {
  (
    . "$HOME/.bashrc"
    rbenv local system
    rbenv use system
    install_ruby_utils
    nvm use system
    install_node_utils
  )
  . "$HOME/.bashrc"
  install_pip_utils
  install_ruby_utils
  install_node_utils
  npm install -g how2 \
    tldr \
    cpy-cli \
    strip-json-comments-cli \
    pretty-bytes-cli \
    normalize-newline-cli \
    strip-css-comments-cli \
    json2csv \
    xml2json-command \
    json2yaml
  install_go_utils
  install_cheat
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
