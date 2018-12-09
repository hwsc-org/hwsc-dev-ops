#!/bin/bash

mkdir -p backup/unit-test
mongodump --host $mongo_host:$mongo_port --db dev-user --collection dev-user -u $mongo_user -p $mongo_key  --ssl --sslAllowInvalidCertificates -o backup/unit-test
mongodump --host $mongo_host:$mongo_port --db dev-document --collection dev-document -u $mongo_user -p $mongo_key  --ssl --sslAllowInvalidCertificates -o backup/unit-test