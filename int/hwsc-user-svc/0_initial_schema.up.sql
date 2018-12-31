CREATE SCHEMA user_svc;

CREATE DOMAIN user_svc.user_name AS
  VARCHAR(32) NOT NULL CHECK (VALUE ~ '^[[:alpha:]]+(([''.\s-][[:alpha:]\s])?[[:alpha:]]*)*$');

-- https://github.com/oklog/ulid
CREATE DOMAIN user_svc.ulid AS
  VARCHAR(26) NOT NULL CHECK (LENGTH(VALUE) = 26);

-- https://github.com/segmentio/ksuid
CREATE DOMAIN user_svc.ksuid AS
  VARCHAR(27) NOT NULL CHECK (LENGTH(VALUE) = 27);

CREATE TABLE user_svc.accounts
(
  uuid              user_svc.ulid PRIMARY KEY,
  first_name        user_svc.user_name,
  last_name         user_svc.user_name,
  email             VARCHAR(320) NOT NULL UNIQUE,
  password          VARCHAR(60) NOT NULL,
  organization      TEXT,
  created_date      TIMESTAMP NOT NULL,
  is_verified       BOOLEAN NOT NULL
);

CREATE TABLE user_svc.verify_tokens
(
  token         TEXT PRIMARY KEY,
  created_date  TIMESTAMP NOT NULL,
  uuid          user_svc.ulid REFERENCES user_svc.accounts(uuid) ON DELETE CASCADE
);

CREATE TABLE user_svc.documents
(
  duid      user_svc.ksuid PRIMARY KEY,
  uuid      user_svc.ulid REFERENCES user_svc.accounts(uuid) ON DELETE CASCADE,
  is_public BOOLEAN NOT NULL
);

-- uuid and duid act as unique identifier b/c docs can be shared to any user
CREATE TABLE user_svc.shared_documents
(
  PRIMARY KEY (duid, uuid),
  duid user_svc.ksuid  REFERENCES user_svc.documents(duid) ON DELETE CASCADE,
  uuid user_svc.ulid   REFERENCES user_svc.accounts(uuid) ON DELETE CASCADE
);