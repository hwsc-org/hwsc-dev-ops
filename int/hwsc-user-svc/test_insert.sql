INSERT INTO user_svc.accounts (uuid, first_name, last_name, email, password, organization, created_date, is_verified)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', 'Lisa', 'Kim', 'lisa@test.com', '12345678', 'uwb', current_timestamp, FALSE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', 'Kate Swan', 'Smith-Jones', 'kate@test.com', '12345678', 'cse', current_timestamp, FALSE),
	('0000XSNJG0MQJHBF4QX1EFD6Y5', 'Mary-Jo', 'Allen', 'mary@test.com', '12345678', 'abc', current_timestamp, TRUE),
	('0000XSNJG0MQJHBF4QX1EFD6Y6', 'John F', 'Kennedy', 'john@test.com', '12345678', '123', current_timestamp, TRUE);

INSERT INTO user_svc.documents (uuid, duid, is_public)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujsszwN8NRY24YaXiTIE2VWDTS', FALSE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', '0ujsswThIGTUYm2K8FjOOfXtY1K', TRUE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', '0ujssxh0cECutqzMgbtXSGnjorm', TRUE);

INSERT INTO user_svc.shared_documents (uuid, duid)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujsswThIGTUYm2K8FjOOfXtY1K'),
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujssxh0cECutqzMgbtXSGnjorm');

