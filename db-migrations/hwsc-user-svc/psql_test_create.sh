#!/usr/bin/env bash

docker rm -f devtest;
docker run --name devtest --mount type=bind,source="$(pwd)",target=/psql -d postgres:alpine;
sleep 5;
docker exec -it devtest psql -U postgres -c "CREATE DATABASE testUserdb;";
docker exec -it devtest psql -U postgres -f /psql/test/psql/0_initial_schemas.up.sql;
docker exec -it devtest psql -U postgres -f /psql/psql_test_insert.sql;
docker exec -it devtest psql -U postgres -c "TABLE user_svc.accounts;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.documents;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.shared_documents;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.pending_tokens;";
docker exec -it devtest psql -U postgres -c "TABLE user_security.secret;";
docker exec -it devtest psql -U postgres -c "TABLE user_security.tokens;";

