#!/bin/bash

echo "Running hwsc-document-svc DB local requirement"
MONGODB=$(docker run -it -d -p 27017:27017 -e MONGO_INITDB_DATABASE=admin -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret hwsc/test-hwsc-document-svc:latest)
migrate -path ../db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://testDocumentWriter:testDocumentPwd@127.0.0.1:27017/test-document up 2
mongoimport --jsonArray --db test-document --collection test-document --file ../backup/unit-test/dev-document/dev-document.json -h $mongo_host --port $mongo_port -u $mongo_user -p $mongo_key
echo
read -p "Press ENTER to stop hwsc-document-svc DB local requirement"
docker stop $MONGODB
echo
echo "Terminated hwsc-document-svc DB local requirement"
