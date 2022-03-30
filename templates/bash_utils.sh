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

pyenv_install_python() {
  local python_version="$1"

  PYENV_CFLAGS="-I$(brew --prefix openssl)/include"
  PYENV_CFLAGS="-I$(brew --prefix zlib)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix readline)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix sqlite)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix curl)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix bzip2)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(brew --prefix tcl-tk)/include $PYENV_CFLAGS"
  PYENV_CFLAGS="-I$(xcrun --show-sdk-path)/usr/include $PYENV_CFLAGS"

  PYENV_LDFLAGS="-L$(brew --prefix openssl)/lib"
  PYENV_LDFLAGS="-L$(brew --prefix zlib)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix readline)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix sqlite)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix curl)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix bzip2)/lib $PYENV_LDFLAGS"
  PYENV_LDFLAGS="-L$(brew --prefix tcl-tk)/lib $PYENV_LDFLAGS"

  PYENV_PYTHON_CONFIGURE_OPTS="--enable-shared --enable-unicode=ucs2 --build=aarch64-apple-darwin$(uname -r)"
  env CPPFLAGS="$PYENV_CFLAGS" LDFLAGS="$PYENV_LDFLAGS" PYTHON_CONFIGURE_OPTS="$PYENV_PYTHON_CONFIGURE_OPTS" pyenv install -fk "$python_version"
  __ok
}

pyenv_uninstall_python() {
  local python_version="$1"
  rm -rf "$HOME/.pyenv/versions/$python_version"
  __ok
}

start_ssh_agent_and_add_key() {
  eval `ssh-agent -s`
  ssh-add -K "$1"
  __ok
}

mv_2_golang_project_root() {
  while [[ ! $(find . -maxdepth 1 -type d | grep '.git') =~ ./.git && ! $(basename $(cd $PWD/../.. && pwd)) =~ (github.com|golang.org|google.golang.org|gopkg.in) ]]; do
    cd ..
  done
}

install_go_deps_for_project() {
  pushd .
  mv_2_go_project_root
  if [[ ! -f "$PWD/Gopkg.toml" && ! -f "$PWD/Gopkg.lock" ]]; then
    go get -u $(find . -maxdepth 1 ! -path . ! -path '*/\.*' -type d | grep -v vendor | xargs -n 1 -I % echo %/...)
  else
    dep ensure -vendor-only
  fi
  popd
  __ok
}

goenv_install_version() {
  local version="$1"
  goenv install "$version"
  goenv local "$version"
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
  go get -u github.com/golang/protobuf/proto
  go get -u github.com/golang/protobuf/protoc-gen-go
  # go get -u golang.org/x/tools/gotags - This one didnt work with 1.14.0

  # This is needed so that ruby bundle still keeps working
  [[ -f $HOME/go/$version/bin/bundle ]] && mv $HOME/go/$version/bin/bundle $HOME/go/$version/bin/gobundle

  goenv rehash
}

build_static_go_bin() {
  pushd .
  mv_2_go_project_root

  local arch="$(uname -m | tr '[:upper:]' '[:lower:]')"
  local osname="$(uname -s | tr '[:upper:]' '[:lower:]')"
  local archname

  case "$arch" in
    x86_64)
      archname='amd64'
      ;;
    i386)
      archname='386'
      ;;
    *)
      __err "ERROR >> Arch not supported for go build process"
      ;;
  esac
  echo "Building static binary for $osname/$archname"
  CGO_ENABLED=0 gox -osarch="$osname/$archname" -rebuild -tags='netgo' -ldflags='-w -extldflags "-static"'
  popd
  __ok
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

start_default_docker_env() {
  stop_minikube
  echo "$1"
  __ok
}

load_docker_env() {
  case "$1" in
    minikube)
      switch_to_minikube
      ;;
    *)
      if [[ !is_minikube_running ]]; then
        start_default_docker_env "Minikube is not running. So defaulting."
      fi

      if [[ is_minikube_running ]]; then
        eval "$(minikube docker-env)"
      fi
      ;;
  esac
  __ok
}

login_dockerhub() {
  [[ ! -z "$DOCKERHUB_USERNAME" && ! -z "$DOCKERHUB_PASSWORD" ]] \
    || __err "dockerhub creds have not been exported to the shell"
  docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"
  __ok
}

rm_intermediate_docker_images() {
  docker images | grep '<none>' | awk '{print $3}' | xargs -n 1 -I % docker rmi -f %
  __ok
}

rm_stopped_docker_containers() {
  docker ps --filter status=exited --filter status=dead --format="{{ .ID }} {{ .Names }}" \
    | awk '{print $1}' \
    | xargs -n 1 -I % docker rm %
  __ok
}

stop_docker_containers() {
  docker ps --filter status=running --filter status=restarting --filter status=removing --filter status=created --format="{{ .ID }} {{ .Names }}" \
    | awk '{print $1}' \
    | xargs -n 1 -I % docker stop %
  __ok
}

kube_set_creds() {
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

clean_ensime_sbt_cache() {
  rm -rf ~/.coursier/cache/v1/https/oss.sonatype.org/content/repositories/snapshots \
    ~/.ivy2/cache/org.ensime \
    ~/.ivy2/local \
    project/target \
    ~/.sbt/0.13/target \
    ~/.sbt/0.13/plugins/target
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
gem_lock_file="$(find . -maxdepth 3 -type f -name 'Gemfile.lock')"
if [[ -n "$ruby_version_file" ]]; then
  ruby_version="$(head -n 1 "$ruby_version_file")"
  eval "$(rbenv init -)"
  rbenv versions | grep "$ruby_version" || rbenv install "$ruby_version"
  rbenv shell "$ruby_version"
  rbenv local "$ruby_version"
  rbenv rehash
  gem env home
  if [[ -n "$gem_lock_file" ]]; then
    bundle install
  fi
  rbenv rehash
fi

python_version_file="$(find . -maxdepth 3 -type f -name '.python-version')"
pipenv_lock_file="$(find . -maxdepth 3 -type f -name 'Pipfile.lock')"
if [[ -n "$python_version_file" ]]; then
  python_version="$(head -n 1 "$python_version_file")"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv versions | grep "$python_version" || pyenv install
  pyenv local "$python_version"
  pyenv rehash
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
gopkg_lock_file="$(find . -maxdepth 3 -type f -name 'Gopkg.lock')"
if [[ -n "$golang_version_file" && -n "$gopkg_lock_file" ]]; then
  golang_version="$(head -n 1 "$golang_version_file")"
  goenv versions | grep -i "$golang_version" >/dev/null 2>&1 || goenv install
  goenv rehash >/dev/null
  mkdir -p $HOME/go/$golang_version/src
  mkdir -p $HOME/go/$golang_version/pkg
  mkdir -p $HOME/go/$golang_version/bin
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
EOF
  fi
}
