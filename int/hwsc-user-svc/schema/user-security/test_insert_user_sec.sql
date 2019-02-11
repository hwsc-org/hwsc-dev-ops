INSERT INTO user_security.secret (secret_key, created_timestamp)
VALUES
  ('someSecretKey', current_timestamp),
  ('anotherSecretKey', current_timestamp);

INSERT INTO user_security.tokens (token_string, secret_key, token_type, algorithm, permission, expiration_date, uuid)
VALUES
  ('some token', 'someSecretKey', 'JWT', 'HS256', 'USER', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y3'),
  ('another token', 'anotherSecretKey', 'NO_TYPE', 'NO_ALG', 'NO_PERM', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y6');