#!/usr/bin/env bash
set -euo pipefail

# Run from the repository root after starting the primary service.
# The backup is written under ./backups, which is intentionally gitignored.
mkdir -p backups
docker exec pg-primary mkdir -p /backups

docker exec pg-primary pg_dump -U postgres -d bootcamp -Fc -f /backups/bootcamp.dump

if ! docker exec pg-primary psql -U postgres -d postgres -tAc \
  "SELECT 1 FROM pg_database WHERE datname = 'bootcamp_check'" | grep -q 1; then
  docker exec pg-primary createdb -U postgres bootcamp_check
fi

docker exec pg-primary pg_restore -U postgres -d bootcamp_check --clean --if-exists /backups/bootcamp.dump

echo "Restored student records:"
docker exec pg-primary psql -U postgres -d bootcamp_check -c "SELECT * FROM students ORDER BY id;"
