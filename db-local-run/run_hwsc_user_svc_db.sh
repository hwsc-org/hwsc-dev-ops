#!/usr/bin/env bash

PASSWORD=$hosts_postgres_password
DB=$hosts_postgres_db

HOST=$hosts_postgres_host
PORT=$hosts_postgres_port
USER=$hosts_postgres_user
SSLMODE=$hosts_postgres_sslmode

MIGRATION_PATH=../db-migrations/hwsc-user-svc/test/psql/
POSTGRES_URI=postgres://$USER:$PASSWORD@$HOST:$PORT/$DB?sslmode=$SSLMODE

echo "Launching a local postgres container for hwsc-user-svc:"
CONTAINER_ID=$(docker run -d -p 5432:5432 --rm -e POSTGRES_PASSWORD=$PASSWORD -e POSTGRES_DB=$DB postgres:alpine)
echo $CONTAINER_ID
sleep 3;
echo
echo "Running all psql migration files:"
migrate -path $MIGRATION_PATH -database $POSTGRES_URI up
echo
read -p "Press ENTER to stop and remove Postgres container for hwsc-user-svc:"
docker stop $CONTAINER_ID
