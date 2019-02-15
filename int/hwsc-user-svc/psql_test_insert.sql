INSERT INTO user_svc.accounts (uuid, first_name, last_name, email, password, organization, created_date, is_verified, permission_level)
VALUES
	('0000xsnjg0mqjhbf4qx1efd6y3', 'Lisa', 'Kim', 'lisa@test.com', '12345678', 'uwb', current_timestamp, TRUE, 'USER_REGISTRATION'),
	('0000xsnjg0mqjhbf4qx1efd6y4', 'Kate Swan', 'Smith-Jones', 'kate@test.com', '12345678', 'cse', current_timestamp, TRUE, 'USER_REGISTRATION'),
	('0000xsnjg0mqjhbf4qx1efd6y5', 'Mary-Jo', 'Allen', 'mary@test.com', '12345678', 'abc', current_timestamp, FALSE, 'USER_REGISTRATION'),
	('0000xsnjg0mqjhbf4qx1efd6y6', 'John F', 'Kennedy', 'john@test.com', '12345678', '123', current_timestamp, FALSE, 'USER_REGISTRATION');

INSERT INTO user_svc.documents (duid, uuid, is_public)
VALUES
	('0ujsszwN8NRY24YaXiTIE2VWDTS', '0000xsnjg0mqjhbf4qx1efd6y3', FALSE),
	('0ujsswThIGTUYm2K8FjOOfXtY1K', '0000xsnjg0mqjhbf4qx1efd6y4', TRUE),
	('0ujssxh0cECutqzMgbtXSGnjorm', '0000xsnjg0mqjhbf4qx1efd6y4', TRUE);

INSERT INTO user_svc.shared_documents (duid, uuid)
VALUES
	('0ujsswThIGTUYm2K8FjOOfXtY1K', '0000xsnjg0mqjhbf4qx1efd6y3'),
	('0ujssxh0cECutqzMgbtXSGnjorm', '0000xsnjg0mqjhbf4qx1efd6y3');

INSERT INTO user_svc.pending_tokens (token, created_date, uuid)
VALUES
  ('som2342wralwekjasf90ae2#$@', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y5'),
  ('alskjdfaofuOIUFOSIJFdklsfj', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y6');


UPDATE user_svc.accounts SET
  first_name = 'NewLisa',
  last_name = 'NewKim',
  organization = 'new',
  password = 'new1234566789',
  prospective_email = (CASE WHEN LENGTH('new@new.new') = 0 THEN NULL ELSE 'new@new.new' END)
WHERE user_svc.accounts.uuid = '0000xsnjg0mqjhbf4qx1efd6y3';


INSERT INTO user_security.secret (secret_key, created_timestamp, expiration_timestamp, is_active)
VALUES
  ('someSecretKey', current_timestamp, current_timestamp, true),
  ('anotherSecretKey', current_timestamp, current_timestamp, false);

INSERT INTO user_security.tokens (token_string, secret_key, token_type, algorithm, permission, expiration_date, uuid)
VALUES
  ('some token', 'someSecretKey', 'JWT', 'HS256', 'USER', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y3'),
  ('another token', 'anotherSecretKey', 'NO_TYPE', 'NO_ALG', 'NO_PERM', current_timestamp, '0000xsnjg0mqjhbf4qx1efd6y6');