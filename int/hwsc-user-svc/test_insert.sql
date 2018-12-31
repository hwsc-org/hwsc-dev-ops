INSERT INTO user_svc.accounts (uuid, first_name, last_name, email, password, organization, created_date, is_verified)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', 'Lisa', 'Kim', 'lisa@test.com', '12345678', 'uwb', current_timestamp, TRUE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', 'Kate Swan', 'Smith-Jones', 'kate@test.com', '12345678', 'cse', current_timestamp, TRUE),
	('0000XSNJG0MQJHBF4QX1EFD6Y5', 'Mary-Jo', 'Allen', 'mary@test.com', '12345678', 'abc', current_timestamp, FALSE),
	('0000XSNJG0MQJHBF4QX1EFD6Y6', 'John F', 'Kennedy', 'john@test.com', '12345678', '123', current_timestamp, FALSE);

INSERT INTO user_svc.documents (duid, uuid, is_public)
VALUES
	('0ujsszwN8NRY24YaXiTIE2VWDTS', '0000XSNJG0MQJHBF4QX1EFD6Y3', FALSE),
	('0ujsswThIGTUYm2K8FjOOfXtY1K', '0000XSNJG0MQJHBF4QX1EFD6Y4', TRUE),
	('0ujssxh0cECutqzMgbtXSGnjorm', '0000XSNJG0MQJHBF4QX1EFD6Y4', TRUE);

INSERT INTO user_svc.shared_documents (duid, uuid)
VALUES
	('0ujsswThIGTUYm2K8FjOOfXtY1K', '0000XSNJG0MQJHBF4QX1EFD6Y3'),
	('0ujssxh0cECutqzMgbtXSGnjorm', '0000XSNJG0MQJHBF4QX1EFD6Y3');

INSERT INTO user_svc.verify_tokens (token, created_date, uuid)
VALUES
  ('som2342wralwekjasf90ae2#$@', current_timestamp, '0000XSNJG0MQJHBF4QX1EFD6Y5'),
  ('alskjdfaofuOIUFOSIJFdklsfj', current_timestamp, '0000XSNJG0MQJHBF4QX1EFD6Y6');