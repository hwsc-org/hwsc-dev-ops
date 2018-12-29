CREATE DOMAIN user_name AS
  VARCHAR(32) NOT NULL CHECK (VALUE ~ '^[[:alpha:]]+(([''.\s-][[:alpha:]\s])?[[:alpha:]]*)*$');

-- https://github.com/oklog/ulid
CREATE DOMAIN ulid AS
  VARCHAR(26) NOT NULL CHECK (LENGTH(VALUE) = 26);

-- https://github.com/segmentio/ksuid
CREATE DOMAIN ksuid AS
  VARCHAR(27) NOT NULL CHECK (LENGTH(VALUE) = 27);

CREATE TABLE schema_version
(
  major_version INTEGER NOT NULL,
  minor_version FLOAT NOT NULL,
  date_start    TIMESTAMP NOT NULL,
  date_end      TIMESTAMP DEFAULT NULL
);

CREATE TABLE user_account
(
  uuid              ULID PRIMARY KEY,
  first_name        USER_NAME,
  last_name         USER_NAME,
  email             VARCHAR(320) NOT NULL UNIQUE,
  password          VARCHAR(60) NOT NULL,
  organization      TEXT,
  created_date      DATE NOT NULL DEFAULT CURRENT_DATE,
  is_verified       BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE documents
(
  uuid      ULID REFERENCES user_account(uuid) ON DELETE CASCADE,
  duid      KSUID PRIMARY KEY,
  is_public BOOLEAN NOT NULL
);

-- uuid and duid act as unique identifier b/c docs can be shared to any user
CREATE TABLE shared_documents
(
  PRIMARY KEY (uuid, duid),
  uuid ULID   REFERENCES user_account(uuid) ON DELETE CASCADE,
  duid KSUID  REFERENCES documents(duid) ON DELETE CASCADE
);