#!/usr/bin/env bash

prep_docker_machine() {
  docker-machine ls -q | grep '^default$' \
    || docker-machine create --driver virtualbox default
  eval $(docker-machine env)
  docker-machine env
}

update_bash_profile() {
  echo "docker-machine ls | awk '{if(NR>1) print \$1,\$3,\$4,\$5}' | grep -i '^default virtualbox' 2>&1 >/dev/null || docker-machine create --driver virtualbox default" >> $HOME/.bash_profile
  echo 'eval "$(docker-machine env default)"' >> $HOME/.bash_profile
  echo "env | grep DOCKER | grep DOCKER_HOST | cut -d '=' -f2 | sed -e 's#tcp://##g;s#:# #g' | xargs nc -v \\" >> $HOME/.bash_profile
  echo '|| (docker-machine stop default 2>&1 >/dev/null; eval "$(docker-machine env -u)"; docker-machine start default; eval "$(docker-machine env default)")' >> $HOME/.bash_profile
}

test_docker() {
  docker run hello-world
}

main() {
  prep_docker_machine
  update_bash_profile
  test_docker
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
