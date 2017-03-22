#!/usr/bin/env bash

main() {
  curl -H "Cache-Control: no-cache" \
    -s \
    -S \
    -L \
    https://raw.githubusercontent.com/sumanmukherjee03/tmux_setup/master/bootstrap.sh \
    | bash
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
