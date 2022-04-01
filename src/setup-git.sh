#!/usr/bin/env bash

main() {
  local name="$1"
  local email="$2"
  curl -H "Cache-Control: no-cache" \
    -s \
    -S \
    -L \
    https://raw.githubusercontent.com/sumanmukherjee03/git-setup/master/bootstrap.sh \
    | bash /dev/stdin "$name" "$email"

  git secrets --register-aws --global
  git secrets --install "$HOME/.git-templates/git-secrets"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
