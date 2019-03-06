INSERT INTO user_svc.accounts
  (uuid, first_name, last_name, email, password, organization, created_timestamp, is_verified, permission_level)
VALUES
('0000xsnjg0mqjhbf4qx1efd6y3', 'IntegrationTest', 'TestVerifyAuthToken', 'vat@test.com', 'pass', 'uwb', current_timestamp, FALSE, 'USER_REGISTRATION');

INSERT INTO user_svc.email_tokens
  (token, created_timestamp, expiration_timestamp, uuid)
VALUES
('mXRLhKATqLq0-5mQ4O9iUob9W896uUhXBT9JrkWMpNs=', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '14 day', '0000xsnjg0mqjhbf4qx1efd6y3');