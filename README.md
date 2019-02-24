# hwsc-dev-ops
Resources for managing our services

## Requirements:

1. Read the docs for [golang-migrate](https://github.com/golang-migrate/migrate)
2. Download the [CLI](https://github.com/golang-migrate/migrate/tree/master/cli) using `$ brew install golang-migrate`
3. Install [Mongo](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x)

## Int/Ext Database Migration
1. TODO

### Unit/Integration Test Database Migration
1. Test your migration using the CLI with Docker containers and migration directory `db-migrations/{service name}/test`
2. Build [Docker containers](https://github.com/hwsc-org/hwsc-dev-ops/tree/master/dockerfiles) if you need to set DB configurations that are not covered by the migration e.g. making a new database in MongoDB or setting up initial admin account.
3. Migrations do not persist in Docker containers, therefore restarting the container does not reflect migration changes.

### Sample Workflow
1. Run `$ docker run -it -p 27017:27017 -e MONGO_INITDB_DATABASE=admin -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret hwsc/test-hwsc-document-svc:latest`
2. Up migrate `$ migrate -path db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://testDocumentWriter:testDocumentPwd@127.0.0.1:27017/test-document up 2`
3. Down migrate `$ migrate -path db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://testDocumentWriter:testDocumentPwd@127.0.0.1:27017/test-document down 2`
4. Stopping the Docker DB container will require you to run the migration again.

## hwsc-document-svc Integration Test
# WARNING: 
- Always check your hard drive memory!
- Run `docker ps` to check for running containers!
- Stop containers as necessary!
- Remove images as necessary!

### Manual Integration Test
1. `$ docker run -it -p 27017:27017 -e MONGO_INITDB_DATABASE=admin -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret hwsc/test-hwsc-document-svc:latest`
2. This runs the following MongoDB database:
    - `admin` at `mongodb://mongoadmin:secret@127.0.0.1:27017/admin`
    - `test-document` at `mongodb://testDocumentWriter:testDocumentPwd@127.0.0.1:27017/test-document`
3. `$ migrate -path db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://testDocumentWriter:testDocumentPwd@127.0.0.1:27017/test-document up 2`
4. Grab the config file from Slack channel #config-files-test
5. `mongoimport --jsonArray --db test-document --collection test-document --file backup/unit-test/dev-document/test-document.json -h $mongo_host --port $mongo_port -u $mongo_user -p $mongo_key`
6. Clone [hwsc-document-svc](https://github.com/hwsc-org/hwsc-document-svc) in a directory
7. Change directory to `github.com/hwsc-org/hwsc-document-svc`
8. Run the service `$ go run main.go`
8. Clone [hwsc-api-blocks](https://github.com/hwsc-org/hwsc-api-blocks) in a directory
9. Change directory to `github.com/hwsc-org/hwsc-api-blocks/integration_tests`
10. Run hwsc-document-svc integration test

### Scripted Integration Test
1. Grab the config file from Slack channel #config-files-test
2. `$ cd db-local-run`
3. `$ bash run_hwsc_document_svc.sh`
4. Clone [hwsc-document-svc](https://github.com/hwsc-org/hwsc-document-svc) in a directory
5. Change directory to `github.com/hwsc-org/hwsc-document-svc`
6. Run the service `$ go run main.go`
7. Clone [hwsc-api-blocks](https://github.com/hwsc-org/hwsc-api-blocks) in a directory
8. Change directory to `github.com/hwsc-org/hwsc-api-blocks/integration_tests`
9. Run hwsc-document-svc integration test

## Scripts
To restore dev-document MongoDB
- Use config file from Slack channel #config-files-dev
- `mongo $mongo_host:$mongo_port/dev-document -u $mongo_user --password=$mongo_key` 
- `db['dev-document'].remove({})`
- `exit`
- `cd $GOPATH/src/github.com/hwsc-org/hwsc-dev-ops`
- `mongoimport --jsonArray --db dev-document --collection dev-document --file backup/unit-test/dev-document/dev-document.json -h $mongo_host --port $mongo_port -u $mongo_user -p $mongo_key`
