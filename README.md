# hwsc-dev-ops
Resources for managing our services

## Scripts
 To restore dev-document MongoDB
- `mongo $mongo_host:$mongo_port/dev-document -u $mongo_user --password=$mongo_key` 
- `db['dev-document'].remove({})`
- `exit`
- `cd $GOPATH/src/github.com/hwsc-org/hwsc-dev-ops`
- `mongoimport --jsonArray --db dev-document --collection dev-document --file backup/unit-test/dev-document/dev-document.json -h $mongo_host --port $mongo_port -u $mongo_user -p $mongo_key`