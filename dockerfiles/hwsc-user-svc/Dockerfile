FROM postgres:alpine

# required default value, but will be overwritten with --build-args
ARG db_name=""

# db_name grabbed from --build-args from docker build command
ENV POSTGRES_DB=${db_name}

# after entrypoint calls initdb to create default postgres user and db,
# auto runs any *.sql files (and any *.sh files), before starting the service
COPY user_svc_schema.sql /docker-entrypoint-initdb.d/
