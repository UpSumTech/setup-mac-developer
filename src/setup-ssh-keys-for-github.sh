#!/usr/bin/env bash

generate_ssh_key() {
  if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-keygen -t rsa -b 4096 -C "$USER_EMAIL"
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_rsa"
  fi
}

copy_key_to_github() {
  pbcopy < $HOME/.ssh/id_rsa.pub
  echo "The key has been copied to your clipboard"
  echo "Have you added the key to Github?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) break;;
      No ) exit;;
    esac
  done
}

main() {
  generate_ssh_key
  copy_key_to_github
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
