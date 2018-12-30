# hwsc-dev-ops
Resources for managing our services

## Scripts
 Back-up a MongoDB server using the environment variables
- `backup_mongodb_server.sh `
 To restore dev-document MongoDB
- `mongorestore --host $mongo_host:$mongo_port --db dev-document --collection dev-document -u $mongo_user -p $mongo_key  --ssl --sslAllowInvalidCertificates --drop --noIndexRestore backup/unit-test/dev-document/dev-document.bson`