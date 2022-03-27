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
  command -v pg_resetwal >/dev/null 2>&1 \
    && pg_resetwal -D "$PGDATA" -f || echo 'no need of resetting DB'
  rm -rf "$PGDATA"
  command -v initdb >/dev/null 2>&1 \
    && initdb -D "$PGDATA"
  __ok
}

start_postgres() {
  [[ ! -z $PGDATA ]] || export PGDATA="$HOME/var/data/postgres"
  local pg_log_dir="$HOME/var/log/postgres"
  ps -ef | grep -i 'postgres: writer proces[s]' \
    || pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" -w start
  __ok
}

stop_postgres() {
  local pg_log_dir="$HOME/var/log/postgres"
  if ps -ef | grep -i 'postgres: writer proces[s]'; then
    pg_ctl -D "$PGDATA" -l "$pg_log_dir/server.log" -w stop \
      || pg_ctl -D "$(brew --prefix)/var/postgresql@10" -w stop
  fi
  __ok
}

setup_root() {
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "CREATE USER root WITH SUPERUSER;"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "ALTER USER root CREATEROLE CREATEDB;"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "ALTER USER root WITH PASSWORD 'welcome2psql';"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "CREATE DATABASE root OWNER root;"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "ALTER DATABASE postgres OWNER TO root;"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "ALTER DATABASE template0 OWNER TO root;"
  psql -v ON_ERROR_STOP=1 -h localhost postgres -c "ALTER DATABASE template1 OWNER TO root;"
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
  stop_postgres
  init_postgres
  start_postgres
  setup_root
  update_pg_hba_conf
  stop_postgres
  start_postgres
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
