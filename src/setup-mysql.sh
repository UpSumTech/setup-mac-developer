#!/usr/bin/env bash

[[ -z "$MYSQL_PASSWORD" ]] || MYSQL_PASSWORD='welcome2mysql'

check_mysql() {
  command -v mysql.server \
    || { echo "ERROR >> mysql is not installed"; exit 1; }
}

start_mysql() {
  ps -ef | grep mysql[d] \
    || mysql.server start
}

setup_root() {
  mysqladmin -u root password "$MYSQL_PASSWORD"
}

post_setup_mod() {
  mysql -h localhost --user=root --password="$MYSQL_PASSWORD" --execute="SET @@global.sql_mode='';"
}

main() {
  check_mysql
  start_mysql
  setup_root
  post_setup_mod
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
