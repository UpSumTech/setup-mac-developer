#!/usr/bin/env bash

main() {
  # TODO : Get user input for author name and email for git
  curl -H "Cache-Control: no-cache" \
    -s \
    -S \
    -L \
    https://raw.githubusercontent.com/sumanmukherjee03/git-setup/master/bootstrap.sh \
    | bash /dev/stdin "$USER_FULLNAME" "$USER_EMAIL"
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
