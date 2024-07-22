#!/bin/bash

if [ -z "$DB_HOST" ] || [ -z "$DB_PORT" ] || [ -z "$DB_USER" ] || [ -z "$DB_NAME" ]; then
  echo "Error: Required environment variables DB_HOST, DB_PORT, DB_USER, or DB_NAME are not set."
  exit 1
fi

while ! pg_isready -q -h $DB_HOST -p $DB_PORT -U $DB_USER
do
   echo "DB_HOST: $DB_HOST, DB_PORT: $DB_PORT, DB_USER: $DB_USER"
  echo "$(date) - waiting for database to start"
  sleep 2
done


# Run migrations
mix ecto.migrate

# Start the Phoenix server
exec mix phx.server
