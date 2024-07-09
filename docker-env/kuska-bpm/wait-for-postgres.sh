#!/bin/bash
set -e

echo 'Waiting for PostgreSQL to be available'
maxTries=10

while [ "$maxTries" -gt 0 ] && [ $(echo 'QUIT' | nc -w 1 "$DB_HOST" 5432; echo "$?") -gt 0 ]; do
    sleep 1
    let maxTries--
done

if [ "$maxTries" -le 0 ]; then
    echo >&2 'error: unable to contact Postgres after 10 tries'
    exit 1
fi

# Execute the original command
exec "$@"