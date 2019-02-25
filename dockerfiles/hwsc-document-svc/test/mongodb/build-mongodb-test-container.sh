#!/bin/bash

docker build -t test-hwsc-document-svc-mongodb .
docker tag test-hwsc-document-svc-mongodb hwsc/test-hwsc-document-svc-mongodb
docker push hwsc/test-hwsc-document-svc-mongodb
