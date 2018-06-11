#!/usr/bin/env bash

prep_docker_machine() {
  docker-machine ls -q | grep '^default$' \
    || docker-machine create --driver virtualbox default
  eval "$(docker-machine env)"
  docker-machine env
  docker-machine start default
  docker run hello-world
}

main() {
  prep_docker_machine
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
