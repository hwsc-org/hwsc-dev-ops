CREATE TYPE permission_level AS ENUM
    (
        'NO_PERM',
        'USER_REGISTRATION',
        'USER',
        'ADMIN'
        );

-- https://github.com/oklog/ulid
CREATE DOMAIN ulid AS
    VARCHAR(26) NOT NULL CHECK (LENGTH(VALUE) = 26);

CREATE SCHEMA user_svc;

CREATE DOMAIN user_svc.user_name AS
    VARCHAR(32) NOT NULL CHECK (VALUE ~ '^[[:alpha:]]+(([''.\s-][[:alpha:]\s])?[[:alpha:]]*)*$');

-- https://github.com/segmentio/ksuid
CREATE DOMAIN user_svc.ksuid AS
    VARCHAR(27) NOT NULL CHECK (LENGTH(VALUE) = 27);

CREATE TABLE user_svc.accounts
(
    uuid               ulid PRIMARY KEY,
    first_name         user_svc.user_name,
    last_name          user_svc.user_name,
    email              VARCHAR(320)     NOT NULL UNIQUE,
    prospective_email  VARCHAR(320) UNIQUE DEFAULT NULL,
    password           VARCHAR(60)      NOT NULL,
    organization       TEXT,
    created_timestamp  TIMESTAMPTZ      NOT NULL,
    modified_timestamp TIMESTAMPTZ         DEFAULT NULL,
    is_verified        BOOLEAN          NOT NULL,
    permission_level   permission_level NOT NULL
);

CREATE TABLE user_svc.email_tokens
(
    token                TEXT PRIMARY KEY,
    secret_key           TEXT NOT NULL,
    created_timestamp    TIMESTAMPTZ NOT NULL,
    expiration_timestamp TIMESTAMPTZ NOT NULL,
    uuid                 ulid UNIQUE REFERENCES user_svc.accounts (uuid) ON DELETE CASCADE
);

CREATE TABLE user_svc.documents
(
    duid      user_svc.ksuid PRIMARY KEY,
    uuid      ulid REFERENCES user_svc.accounts (uuid) ON DELETE CASCADE,
    is_public BOOLEAN NOT NULL
);

-- uuid and duid act as unique identifier b/c docs can be shared to any user
CREATE TABLE user_svc.shared_documents
(
    PRIMARY KEY (duid, uuid),
    duid user_svc.ksuid REFERENCES user_svc.documents (duid) ON DELETE CASCADE,
    uuid ulid REFERENCES user_svc.accounts (uuid) ON DELETE CASCADE
);

CREATE SCHEMA user_security;

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

CREATE TABLE user_security.secrets
(
    secret_key           TEXT PRIMARY KEY,
    created_timestamp    TIMESTAMPTZ NOT NULL,
    expiration_timestamp TIMESTAMPTZ NOT NULL
);

CREATE TABLE user_security.auth_tokens
(
    token                TEXT PRIMARY KEY,
    secret_key           TEXT REFERENCES user_security.secrets (secret_key) ON DELETE CASCADE,
    token_type           user_security.token_type     NOT NULL,
    algorithm            user_security.algorithm_type NOT NULL,
    permission           permission_level             NOT NULL,
    expiration_timestamp TIMESTAMPTZ                  NOT NULL,
    uuid                 ulid                         NOT NULL
);
CREATE UNIQUE INDEX user_svc_accounts_email_pw_index ON user_svc.accounts (email, password);
CREATE UNIQUE INDEX user_svc_accounts_prosp_email_index ON user_svc.accounts (prospective_email);
CREATE TABLE user_security.active_secret
(
    secret_key           TEXT REFERENCES user_security.secrets (secret_key) ON DELETE CASCADE,
    created_timestamp    TIMESTAMPTZ,
    expiration_timestamp TIMESTAMPTZ,
    one_row              bool PRIMARY KEY DEFAULT TRUE
        CONSTRAINT one_row_allowed CHECK (one_row)
);

CREATE FUNCTION insert_new_active_secret() RETURNS trigger AS
$BODY$
BEGIN
    EXECUTE 'DELETE FROM user_security.active_secret';
    INSERT INTO user_security.active_secret(secret_key, created_timestamp, expiration_timestamp, one_row)
    VALUES (NEW.secret_key, NEW.created_timestamp, NEW.expiration_timestamp, TRUE);
    RETURN NEW;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER update_active_secret
    AFTER INSERT
    ON user_security.secrets
    FOR EACH ROW
EXECUTE PROCEDURE insert_new_active_secret();
INSERT INTO user_svc.accounts(uuid, first_name, last_name, email,
                              password,
                              organization, created_timestamp, is_verified, permission_level)
VALUES ('01d793kwwv8ncaamd1b3yr5w48', 'DummyFirstName', 'DummyLastName', 'hwss2018@outlook.com',
        '$2a$04$2fjictug3Q6Q1AHY1BnhA.45VqX2q39VrL0w36X1ucvARqR/NuH3y',
        'HWSC', '2019-03-31 05:45:17.266119 +0000', true, 'USER_REGISTRATION');
