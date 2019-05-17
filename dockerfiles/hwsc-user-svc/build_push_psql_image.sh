#!/usr/bin/env bash

# combine all *.up.sql files into one sql file for docker build to consume
cat ../../db-migrations/hwsc-user-svc/test/psql/*.up.sql > user_svc_schema.sql

# build an image from a docker file, -t = name and optionally a tag in the 'name:tag' format
# docker build [OPTIONS] PATH
docker build \
--build-arg user=$hosts_postgres_user \
--build-arg password=$hosts_postgres_password \
--build-arg db_name=$hosts_postgres_db \
-t hwsc/hwsc-user-svc-psql:test-int .

# docker login
docker login -u $docker_user --password $docker_password

# push an image or a repo to a registry
# docker push [OPTIONS] NAME[:TAG]
docker push hwsc/hwsc-user-svc-psql:test-int
