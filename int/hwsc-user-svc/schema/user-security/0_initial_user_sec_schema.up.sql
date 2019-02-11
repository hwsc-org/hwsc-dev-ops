CREATE SCHEMA user_security;

-- https://github.com/oklog/ulid
CREATE DOMAIN user_security.ulid AS
  VARCHAR(26) NOT NULL CHECK (LENGTH(VALUE) = 26);

CREATE TYPE user_security.permission_level AS ENUM
(
  'NO_PERM',
  'USER',
  'ADMIN'
);

CREATE TYPE user_security.algorithm_type AS ENUM
(
  'NO_ALG',
  'HS256',
  'HS512'
);

CREATE TYPE user_security.token_type AS ENUM
(
  'NO_TYPE',
  'JWT'
);

CREATE TABLE user_security.secret
(
  secret_key        TEXT PRIMARY KEY,
  created_timestamp TIMESTAMPTZ NOT NULL
);

CREATE TABLE user_security.tokens
(
  token_string      TEXT PRIMARY KEY,
  secret_key        TEXT REFERENCES user_security.secret(secret_key) ON DELETE CASCADE,
  token_type        user_security.token_type NOT NULL,
  algorithm         user_security.algorithm_type NOT NULL,
  permission        user_security.permission_level NOT NULL,
  expiration_date   TIMESTAMPTZ NOT NULL,
  uuid              user_security.ulid NOT NULL UNIQUE
);