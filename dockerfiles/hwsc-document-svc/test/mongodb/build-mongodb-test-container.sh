#!/bin bash

docker build -t test-hwsc-document-svc .
docker tag test-hwsc-document-svc hwsc/test-hwsc-document-svc
docker push hwsc/test-hwsc-document-svc