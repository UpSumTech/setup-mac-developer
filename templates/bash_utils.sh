#! /usr/bin/env bash

############################## PRIVATE HELPER FNS #############################

__ok() {
  echo -n ""
}

__err() {
  echo "ERROR >> $1" >/dev/stderr
}

__check_kubectl() {
  command -v kubectl >/dev/null 2>&1 || __err "You dont have kubectl installed"
}

__chdir_and_exec() {
  local result
  local fn="$1"
  shift 1
  pushd .
  result=$(eval "$(declare -F "$fn")" "$@")
  popd
  echo "$result"
}

get_project_root() {
  local path
  pushd . >/dev/null 2>&1
  path=$(pwd)
  while [[ $(find $path ! -iwholename '*.terraform*' ! -iwholename '*node_modules*' ! -iwholename '*vendor*' -type d -name '.git' -print -prune | wc -l) -eq 0 ]]; do
    cd ..
    path=$(pwd)
  done
  pwd
  popd >/dev/null 2>&1
}

start_ssh_agent_and_add_key() {
  eval `ssh-agent -s`
  ssh-add -K "$1"
  __ok
}

rbenv_install_version() {
  local ruby_version="$1"
  rbenv install $ruby_version
  rbenv shell $ruby_version
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
  __ok
}

pyenv_install_version() {
  local python_version="$1"
  local short_python_version=$(echo "$python_version" | cut -d '.' -f 1,2)

  PYENV_CFLAGS="-I$(brew --prefix openssl)/include"
  PYENV_CFLAGS="-I$(brew --prefix zlib)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix readline)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix sqlite)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix curl)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix bzip2)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix tcl-tk)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix mysql@5.7)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix postgresql@10)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(xcrun --show-sdk-path)/usr/include $PYENV_CFLAGS"

  PYENV_LDFLAGS="-L$(brew --prefix openssl)/lib"
  PYENV_LDFLAGS="-L$(brew --prefix zlib)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix readline)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix sqlite)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix curl)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix bzip2)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix tcl-tk)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix mysql@5.7)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix postgresql@10)/lib $PYENV_LDFLAGS"

  PYENV_PYTHON_CONFIGURE_OPTS="--enable-shared --enable-unicode=ucs2 --build=aarch64-apple-darwin$(uname -r)"
  env CPPFLAGS="$PYENV_CFLAGS" LDFLAGS="$PYENV_LDFLAGS" PYTHON_CONFIGURE_OPTS="$PYENV_PYTHON_CONFIGURE_OPTS" pyenv install -fk "$python_version"

  pyenv shell $python_version
  python${short_python_version} -m pip --trusted-host pypi.python.org install doitlive \
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

  __ok
}

goenv_install_version() {
  local version="$1"
  goenv install "$version"
  goenv local "$version"
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
  go install github.com/alecthomas/gometalinter@latest
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
  go install github.com/motemen/gore/cmd/gore@latest
  go install golang.org/x/tools/cmd/godoc@latest
  go install mvdan.cc/sh/cmd/shfmt@latest
  go install github.com/fatih/hclfmt@latest
  go install github.com/fatih/motion@latest
  go install github.com/golang/protobuf/proto@latest
  go install github.com/golang/protobuf/protoc-gen-go@latest
  goenv rehash
  __ok
}

go_build() {
  local arch="$(uname -m | tr '[:upper:]' '[:lower:]')"
  local osname="$(uname -s | tr '[:upper:]' '[:lower:]')"
  GOOS=$osname GOARCH=$arch CGO_ENABLED=0 go build -ldflags='-extldflags=-static' -tags osusergo,netgo -o $(basename $(pwd))-$osname-$arch
  __ok
}

tgenv_install_version() {
  local version="$1"
  TGENV_ARCH=$(uname -m) tgenv install "$version"
}

tfenv_install_version() {
  local version="$1"
  TFENV_ARCH=$(uname -m) tfenv install "$version"
}

start_minikube() {
  (minikube status | grep -i "running" || (minikube start)) &
  wait
  eval "$(minikube docker-env)"
  __ok
}

stop_minikube() {
  (minikube status | grep -i "running" && (minikube stop)) &
  wait
  unset ${!DOCKER_*}
  __ok
}

is_minikube_running() {
  minikube status | grep -i "running" >/dev/null 2>&1
}

switch_to_minikube() {
  start_minikube
  __ok
}

login_dockerhub() {
  [[ ! -z "$DOCKERHUB_USERNAME" && ! -z "$DOCKERHUB_PASSWORD" ]] \
    || __err "dockerhub creds have not been exported to the shell"
  docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"
  __ok
}

stop_docker_containers() {
  docker ps --filter status=running --filter status=restarting --filter status=removing --filter status=created --format="{{ .ID }} {{ .Names }}" \
    | awk '{print $1}' \
    | xargs -n 1 -I % docker stop %
  __ok
}

rm_stopped_docker_containers() {
  docker ps --filter status=exited --filter status=dead --format="{{ .ID }} {{ .Names }}" \
    | awk '{print $1}' \
    | xargs -n 1 -I % docker rm %
  __ok
}

rm_intermediate_docker_images() {
  docker images | grep '<none>' | awk '{print $3}' | xargs -n 1 -I % docker rmi -f %
  __ok
}

kube_set_creds_for_user() {
  local user="$1"
  __check_kubectl
  kubectl config set-credentials "$user" \
    --certificate-authority="$KUBE_CERTS_DIR/ca.pem" \
    --client-key="$KUBE_CERTS_DIR/key.pem" \
    --client-certificate="$KUBE_CERTS_DIR/cert.pem"
  __ok
}

kube_set_cluster() {
  local cluster="$1"
  local server="$2"
  __check_kubectl
  kubectl config set-cluster "$cluster" \
    --server="$server" \
    --certificate-authority="$KUBE_CERTS_DIR/ca.pem"
  __ok
}

ssh_port_forward() {
  local local_port="$1"
  local remote_server="$2"
  local remote_port="$3"
  if [[ ! -z "$JUMP_HOST" ]]; then
    ssh -o ExitOnForwardFailure=yes -N -L $local_port:$remote_server:$remote_port $JUMP_HOST
  else
    ssh -o ExitOnForwardFailure=yes -N -L $local_port:$remote_server:$remote_port
  fi
  __ok
}

start_mysql() {
  ps -ef | grep mysql[d] \
    || mysql.server start
  __ok
}

stop_mysql() {
  ps -ef | grep mysql[d] \
    && mysql.server stop
  __ok
}

start_psql() {
  [[ ! -z $PGDATA ]] || export PGDATA="$HOME/var/data/postgres"
  local pg_log_dir="$HOME/var/log/postgres"
  ps -ef | grep postgre[s] \
    || pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" start
  __ok
}

stop_psql() {
  local pg_log_dir="$HOME/var/log/postgres"
  ps -ef | grep postgre[s] \
    && pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" stop
  __ok
}

get_ip_info() {
  curl http://api.db-ip.com/v2/free/$1
  echo; nslookup $1 | grep 'name ='
}

open_fzf_finder() {
  command -v fzf \
    || __err "You dont have fzf installed"
  fzf --preview-window 'down:30' --preview '[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (highlight -O ansi -l {} ||
    coderay {} ||
    rougify {} ||
    cat {}) 2> /dev/null | head -500'
}

terraform_check() {
  docker run -t -v $(pwd):/tf bridgecrew/checkov -d /tf
}

sync_history() {
  local current_time=$(date +%s)
  if [[ -z $HISTLASTSYNCED \
    || $(( $current_time - $HISTLASTSYNCED)) -gt 120 ]]; then
    builtin history -a
    local hist_file
    if [[ ! -z "$TMUX" && ! -z "$PROJECT_ROOT_DIR" && $PWD =~ $PROJECT_ROOT_DIR ]]; then
      local hist_dir
      hist_dir="${HOME}/.bash_history.d/$(echo $PROJECT_ROOT_DIR | sed -e "s#$HOME##g;s#^/##g")"
      [[ ! -d "$hist_dir" ]] && mkdir -p "$hist_dir"
      hist_file="${hist_dir}/${USER}_bash_history.txt"
      if [[ ! -f "$hist_file" || ! -s "$hist_file" ]]; then
        touch "$hist_file"
        builtin history | awk '{$1="";print substr($0,2)}' >> "$hist_file"
        [[ -f $HOME/.bash_history ]] && cat $HOME/.bash_history >> "$hist_file"
        cat "$hist_file" | sort -u | sponge "$hist_file"
      fi
    else
      hist_file="$HOME/.bash_history"
    fi
    export HISTFILE="$hist_file"
    builtin history -c
    builtin history -r
    export HISTLASTSYNCED=$(date +%s)
  fi
  __ok
}

activate_history_sync() {
  if [[ ! "sync_history" =~ $PROMPT_COMMAND ]]; then
    export PROMPT_COMMAND="sync_history;$PROMPT_COMMAND"
  fi
  __ok
}

clean_sbt_cache() {
  local version="$1"
  rm -rf ~/.coursier/cache/v1/https/oss.sonatype.org/content/repositories/snapshots \
    ~/.ivy2/cache \
    ~/.ivy2/local \
    project/target \
    $HOME/.sbt/$version/target \
    $HOME/.sbt/$version/plugins/target
  __ok
}

go2_project_root() {
  local path
  path=$(get_project_root)
  cd "$path"
}

set_tmux_pane_props() {
  local bgcolor="$PROFILE_COLOR"
  local fgcolor="black"
  [[ ! -z "$bgcolor" ]] || { bgcolor="default"; fgcolor="green"; }
  tmux set-option pane-active-border-style bg=$bgcolor,fg=$fgcolor
  local file
  mkdir -p $HOME/tmp/tmux_setup
  file=$HOME/tmp/tmux_setup/vars_of_pane_$TMUX_PANE
  echo "bgcolor=$bgcolor" > $file
  echo "fgcolor=$fgcolor" >> $file
}

reset_tmux_pane_props() {
  local file="$HOME/tmp/tmux_setup/vars_of_pane_$TMUX_PANE"
  [[ -s "$file" ]] && rm "$file" \
    || echo -n ''
  tmux set-option pane-active-border-style bg=default,fg=green
}

build_dot_env_file() {
  if [[ -d .git ]]; then
    cat << 'EOF' >> .env
dotenv_file="$(find . -maxdepth 3 -type f -name '.env')"
project_dir="$(pwd)"
project_name="$(basename "$project_dir")"

ruby_version_file="$(find . -maxdepth 3 -type f -name '.ruby-version')"
if [[ -n "$ruby_version_file" ]]; then
  ruby_version="$(head -n 1 "$ruby_version_file")"
  eval "$(rbenv init -)"
  rbenv versions | grep "$ruby_version" || rbenv install "$ruby_version"
  rbenv shell "$ruby_version"
  rbenv local "$ruby_version"
  rbenv rehash
  gem env home
  gem_lock_file="$(find . -maxdepth 3 -type f -name 'Gemfile.lock')"
  if [[ -n "$gem_lock_file" ]]; then
    bundle install
  fi
  rbenv rehash
fi

python_version_file="$(find . -maxdepth 3 -type f -name '.python-version')"
if [[ -n "$python_version_file" ]]; then
  python_version="$(head -n 1 "$python_version_file")"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv versions | grep "$python_version" || pyenv install
  pyenv local "$python_version"
  pyenv rehash
  pipenv_lock_file="$(find . -maxdepth 3 -type f -name 'Pipfile.lock')"
  if [[ -n "$pipenv_lock_file" ]]; then
    pipenv --python "$HOME/.pyenv/versions/$python_version/bin/python"
    pipenv --bare sync
  else
    pyenv virtualenvs | grep "$project_name-$python_version" || pyenv virtualenv $python_version $project_name-$python_version
    pyenv activate $project_name-$python_version
  fi
fi

nvmrc_file="$(find . -maxdepth 3 -type f -name '.nvmrc')"
if [[ -n "$nvmrc_file" ]]; then
  node_version="$(head -n 1 "$nvmrc_file")"
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix)/opt/nvm/nvm.sh" >/dev/null
  nvm ls | grep -i "$node_version" >/dev/null 2>&1 || nvm install
  nvm use >/dev/null
fi

golang_version_file="$(find . -maxdepth 3 -type f -name '.go-version')"
if [[ -n "$golang_version_file" ]]; then
  golang_version="$(head -n 1 "$golang_version_file")"
  goenv versions | grep -i "$golang_version" >/dev/null 2>&1 || goenv install
  goenv rehash >/dev/null
  gopkg_lock_file="$(find . -maxdepth 3 -type f -name 'Gopkg.lock')"
  if [[ -n "$gopkg_lock_file" ]]; then
    go mod init
    go mod tidy
  fi
fi

java_version_file="$(find . -maxdepth 3 -type f -name '.java-version')"
if [[ -n "$java_version_file" ]]; then
  jenv shell "$(head -n 1 "$java_version_file")"
  jenv rehash
fi

terragrunt_version_file="$(find . -maxdepth 3 -type f -name '.terragrunt-version')"
if [[ -n "$terragrunt_version_file" ]]; then
  terragrunt_version="$(head -n 1 "$terragrunt_version_file")"
  tgenv list | grep -i "$terragrunt_version" >/dev/null 2>&1 || tgenv install "$terragrunt_version"
  tgenv use "$terragrunt_version"
fi

terraform_version_file="$(find . -maxdepth 3 -type f -name '.terraform-version')"
if [[ -n "$terraform_version_file" ]]; then
  terraform_version="$(head -n 1 "$terraform_version_file")"
  tfenv list | grep -i "$terraform_version" >/dev/null 2>&1 || tfenv install "$terraform_version"
  tfenv use "$terraform_version"
fi
EOF
  fi
}
