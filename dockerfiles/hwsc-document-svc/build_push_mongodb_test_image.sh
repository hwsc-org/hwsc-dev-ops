#!/bin/bash

docker build -t hwsc/hwsc-document-svc-mongodb:test-int .
docker push hwsc/hwsc-document-svc-mongodb:test-int
