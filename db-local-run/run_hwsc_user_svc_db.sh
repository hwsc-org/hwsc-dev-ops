#!/usr/bin/env bash

PASSWORD=$hosts_postgres_password
DB=$hosts_postgres_db

HOST=$hosts_postgres_host
PORT=$hosts_postgres_port
USER=$hosts_postgres_user
SSLMODE=$hosts_postgres_sslmode

MIGRATION_PATH=../db-migrations/hwsc-user-svc
POSTGRES_URI=postgres://$USER:$PASSWORD@$HOST:$PORT/$DB?sslmode=$SSLMODE

echo "Launching a local postgres container for hwsc-user-svc:"
CONTAINER_ID=$(
    docker run -d \
    --rm \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=$PASSWORD -e POSTGRES_DB=$DB \
    --mount type=bind,source="$(pwd)"/$MIGRATION_PATH,target=/test_files \
    postgres:alpine
    )
echo $CONTAINER_ID
sleep 3;
echo
echo "Running all psql migration files:"
migrate -path $MIGRATION_PATH/test/psql/ -database $POSTGRES_URI up
echo
echo "Seeding Test Data:"
docker exec -it $CONTAINER_ID psql -U $USER $DB -f /test_files/seed_data_integration_test.sql
echo
echo "Displaying Seeded user_svc.accounts"
docker exec -it $CONTAINER_ID psql -U $USER $DB -c "\x" -c "TABLE user_svc.accounts;";
echo "Displaying Seeded user_svc.email_tokens"
docker exec -it $CONTAINER_ID psql -U $USER $DB -c "\x" -c "TABLE user_svc.email_tokens;";
echo
read -p "Press ENTER to stop Postgres container for hwsc-user-svc:"
docker stop $CONTAINER_ID
