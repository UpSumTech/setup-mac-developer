#!/usr/bin/env bash

[[ -z "$PSQL_PASSWORD" ]] || export PSQL_PASSWORD='welcome2psql'

__ok() {
  echo -n ''
}

check_postgres() {
  command -v pg_ctl \
    || { echo "ERROR >> postgres is not installed"; exit 1; }
  __ok
}

prep_for_postgres() {
  mkdir -p "$HOME/var/data/postgres"
  mkdir -p "$HOME/var/log/postgres"
}

init_postgres() {
  pg_ctl -D "$PGDATA" -E 'UTF-8' initdb
  __ok
}

start_postgres() {
  [[ ! -z $PGDATA ]] || export PGDATA="$HOME/var/data/postgres"
  local pg_log_dir="$HOME/var/log/postgres"
  ps -ef | grep postgre[s] \
    || pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" start
  __ok
}

stop_postgres() {
  local pg_log_dir="$HOME/var/log/postgres"
  ps -ef | grep postgre[s] \
    && pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" stop
  __ok
}

setup_root() {
  psql -h localhost postgres -c "CREATE USER root WITH SUPERUSER;"
  psql -h localhost postgres -c "ALTER USER root CREATEROLE CREATEDB;"
  psql -h localhost postgres -c "ALTER USER root WITH PASSWORD 'welcome2psql';"
  psql -h localhost postgres -c "CREATE DATABASE root OWNER root;"
  psql -h localhost postgres -c "ALTER DATABASE postgres OWNER TO root;"
  psql -h localhost postgres -c "ALTER DATABASE template0 OWNER TO root;"
  psql -h localhost postgres -c "ALTER DATABASE template1 OWNER TO root;"
  __ok
}

update_pg_hba_conf() {
  echo -n '' > "$HOME/var/data/postgres/pg_hba.conf"
  echo '# TYPE  DATABASE        USER            ADDRESS                 METHOD' >> "$HOME/var/data/postgres/pg_hba.conf"
  echo "local   all             all                                     md5" >> "$HOME/var/data/postgres/pg_hba.conf"
  echo "host    all             all             127.0.0.1/32            md5" >> "$HOME/var/data/postgres/pg_hba.conf"
  echo "host    all             all             ::1/128                 md5" >> "$HOME/var/data/postgres/pg_hba.conf"
  echo "host    all             all             0.0.0.0/0               md5" >> "$HOME/var/data/postgres/pg_hba.conf"
  __ok
}

main() {
  check_postgres
  prep_for_postgres
  init_postgres
  start_postgres
  setup_root
  update_pg_hba_conf
  stop_postgres
  start_postgres
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
