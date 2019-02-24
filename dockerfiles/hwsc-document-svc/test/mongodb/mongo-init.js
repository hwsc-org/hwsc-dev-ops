db.auth('mongoadmin', 'secret');

db = db.getSiblingDB('test-document')

db.createUser({
    user: 'testDocumentUser',
    pwd: 'testDocumentPwd',
    roles: [
        {
            role: 'readWrite',
            db: 'test-document',
        },
    ],
});
