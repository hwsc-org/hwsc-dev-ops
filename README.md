# hwsc-dev-ops
Resources for managing our services

## Requirements:

1. Read the docs for [golang-migrate](https://github.com/golang-migrate/migrate)
2. Download the [CLI](https://github.com/golang-migrate/migrate/tree/master/cli) using `$ brew install golang-migrate`

## Database Migration

### Tips
1. Test your migration using the CLI with Docker containers and migration directory `db-migrations/{service name}\test`
- E.g. 
    - Run `$ docker run -it -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret mongo:4.0.6`
    - Up migrate `$ migrate -path db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://mongoadmin:secret@127.0.0.1:27017/admin up 1`
    - Down migrate `$ migrate -path db-migrations/hwsc-document-svc/test/mongodb/ -database mongodb://mongoadmin:secret@127.0.0.1:27017/admin up 2`

### hwsc-document-svc


### hwsc-user-svc

## Scripts
 To restore dev-document MongoDB
- `mongo $mongo_host:$mongo_port/dev-document -u $mongo_user --password=$mongo_key` 
- `db['dev-document'].remove({})`
- `exit`
- `cd $GOPATH/src/github.com/hwsc-org/hwsc-dev-ops`
- `mongoimport --jsonArray --db dev-document --collection dev-document --file backup/unit-test/dev-document/dev-document.json -h $mongo_host --port $mongo_port -u $mongo_user -p $mongo_key`