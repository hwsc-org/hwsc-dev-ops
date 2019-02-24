FROM mongo:4.0.6

ENV MONGO_INITDB_ROOT_USERNAME mongoadmin
ENV MONGO_INITDB_ROOT_PASSWORD secret
ENV MONGO_INITDB_DATABASE admin

ADD mongo-init.js /docker-entrypoint-initdb.d/