#!/usr/bin/env bash

docker rm -f devtest;\
docker run --name devtest --mount type=bind,source="$(pwd)",target=/sql -d postgres:alpine;
sleep 5;\
docker exec -it devtest psql -U postgres -c "CREATE DATABASE testUserdb;";
docker exec -it devtest psql -U postgres -f /sql/0_initial_user_svc_schema.up.sql;
docker exec -it devtest psql -U postgres -f /sql/test_insert_user_svc.sql;
docker exec -it devtest psql -U postgres -c "TABLE user_svc.accounts;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.documents;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.shared_documents;";
docker exec -it devtest psql -U postgres -c "TABLE user_svc.pending_tokens;";

