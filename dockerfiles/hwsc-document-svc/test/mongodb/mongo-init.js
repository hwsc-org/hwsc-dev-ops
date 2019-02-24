db.auth('mongoadmin', 'secret');

db = db.getSiblingDB('test-document')

db.createUser({
    user: 'testDocumentWriter',
    pwd: 'testDocumentPwd',
    roles: [
        {
            role: 'readWrite',
            db: 'test-document',
        },
    ],
});

db.createUser({
    user: 'testDocumentReader',
    pwd: 'testDocumentPwd',
    roles: [
        {
            role: 'read',
            db: 'test-document',
        },
    ],
});
