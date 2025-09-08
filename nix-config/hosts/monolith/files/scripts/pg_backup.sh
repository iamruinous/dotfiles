#!/usr/bin/env bash

# Dump individual databases directly to restic repository.
docker exec postgres psql -U postgres -q -l -t -A --pset=pager=off | awk -F'|' '{print $1}' | while read db_name; do
  if [[ -n "$db_name" && "$db_name" != "template0" && "$db_name" != "template1" && "$db_name" != "postgres" && "$db_name" != "postgres=CTc/postgres" ]]; then
    echo "Dumping database '${db_name}'"
    docker exec postgres pg_dump -Fc -Z 9 --user="postgres" --no-owner --no-privileges --dbname="$db_name" > "/data/backup/postgres/${db_name}_$(date +%Y%m%d%H%M%S).dump"
  fi
done
