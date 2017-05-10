#!/usr/bin/env bash

prep_docker_machine() {
  docker-machine create --driver virtualbox default
  eval $(docker-machine env)
  docker-machine env
}

test_docker() {
  docker run hello-world
}

main() {
  prep_docker_machine
  test_docker
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
