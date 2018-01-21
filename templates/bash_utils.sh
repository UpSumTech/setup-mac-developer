###################### PRIVATE HELPER FNS ######################

function __err() {
  echo "ERROR >> $1" 2>&1
  exit 1
}

function __echo_in_dev_mode() {
  echo "$(tput setaf 4)$1$(tput sgr 0)"
}

###################### PUBLIC HELPER FNS #######################

function add_ssh_key_to_agent() {
  local num_of_keys_on_agent
  ps -ef | grep -i "ssh-agen[t]" \
    || eval $(ssh-agent) >/dev/null
  num_of_keys_on_agent="$(ssh-add -l | wc -l | awk '{print $1}')"
  if [[ $num_of_keys_on_agent -eq 0 ]]; then
    ssh-add -K $HOME/.ssh/id_rsa
  elif [[ $num_of_keys_on_agent -eq 1 ]]; then
    return 0
  else
    __err "Too many ssh keys added"
  fi
}

function gen_ssh_key() {
  local file="$1"
  [[ ! -z "$file" ]] || file="$HOME/.ssh/id_rsa"
  [[ "$file" =~ "pub" ]] && __err "Please provide a private key to add"
  if [[ -f "$file" ]]; then
    mv "$file" "${file}.bak"
    mv "${file}.pub" "${file}.pub.bak"
  fi
  ssh-keygen -t rsa -b 4096 -C "$USER_EMAIL" -f "$file" -N ""
}

function start_ssh_agent_and_add_key() {
  eval `ssh-agent -s`
  ssh-add -K ~/.ssh/id_rsa
}

function install_go_deps_for_project() {
  pushd .
  while [[ ! $(find . -maxdepth 1 -type d | grep '.git') =~ './.git' && ! $(basename $(cd $PWD/../.. && pwd)) =~ (github.com|golang.org|google.golang.org|gopkg.in) ]]; do
    cd ..
  done
  go get -u $(find . -maxdepth 1 ! -path . ! -path '*/\.*' -type d | grep -v vendor | xargs -n 1 -I % echo %/...)
  popd
}

function start_docker_machine() {
  (docker-machine ls | awk '{if(NR>1) print $1,$3,$4,$5}' | grep -i '^default virtualbox' 2>&1 >/dev/null \
    || docker-machine create --driver virtualbox --virtualbox-memory "2048" --virtualbox-disk-size "40000" default) &
  eval "$(docker-machine env default)"
  (env | grep DOCKER | grep DOCKER_HOST | cut -d '=' -f2 | sed -e 's#tcp://##g;s#:# #g' | xargs nc -v \
    || (docker-machine stop default 2>&1 >/dev/null; eval "$(docker-machine env -u)"; docker-machine start default; eval "$(docker-machine env default)")) &
  wait
}

function stop_docker_machine() {
  (docker-machine status default | grep -i "running" && (docker-machine stop default)) &
  wait
  eval "$(docker-machine env -u)"
}

function start_minikube() {
  (minikube status | grep -i "running" || (minikube start)) &
  wait
  eval "$(minikube docker-env)"
}

function stop_minikube() {
  (minikube status | grep -i "running" && (minikube stop)) &
  wait
  unset ${!DOCKER_*}
}

function switch_to_minikube() {
  (docker-machine status default | grep -i "running" && (docker-machine stop default)) &
  wait
  eval "$(docker-machine env -u)"
  (minikube status | grep -i "running" || (minikube start)) &
  wait
  eval "$(minikube docker-env)"
}

function switch_to_docker_machine() {
  (minikube status | grep -i "running" && (minikube stop)) &
  wait
  (docker-machine status default | grep -i "running" || (docker-machine start default)) &
  wait
  eval "$(docker-machine env default)"
}

function load_docker_env() {
  if [[ -z "$(docker-machine status default | grep -i "running")" && -z "$(minikube status | grep -i "running")" ]]; then
    start_docker_machine
  else
    if [[ ! -z "$(docker-machine status default | grep -i "running")" && -z "$(minikube status | grep -i "running")" ]]; then
      eval "$(docker-machine env default)"
    fi
    if [[ -z "$(docker-machine status default | grep -i "running")" && ! -z "$(minikube status | grep -i "running")" ]]; then
      eval "$(minikube docker-env)"
    fi
    if [[ ! -z "$(docker-machine status default | grep -i "running")" && ! -z "$(minikube status | grep -i "running")" ]]; then
      echo "Both minikube and docker-machine are running. Switch to one."
    fi
  fi
}
