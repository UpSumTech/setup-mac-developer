#!/usr/bin/env bash

main() {
  mysqladmin -u root password 'welcome2mysql'
  # TODO : Wait for user to log into mysql and type this
  # SET @@global.sql_mode= '';
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
