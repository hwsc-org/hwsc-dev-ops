INSERT INTO user_account (uuid, first_name, last_name, email, password, organization)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', 'Lisa', 'Kim', 'lisa@test.com', '12345678', 'uwb'),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', 'Kate Swan', 'Smith-Jones', 'kate@test.com', '12345678', 'cse'),
	('0000XSNJG0MQJHBF4QX1EFD6Y5', 'Mary-Jo', 'Allen', 'mary@test.com', '12345678', 'abc'),
	('0000XSNJG0MQJHBF4QX1EFD6Y6', 'John F', 'Kennedy', 'john@test.com', '12345678', '123');

INSERT INTO documents (uuid, duid, is_public)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujsszwN8NRY24YaXiTIE2VWDTS', FALSE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', '0ujsswThIGTUYm2K8FjOOfXtY1K', TRUE),
	('0000XSNJG0MQJHBF4QX1EFD6Y4', '0ujssxh0cECutqzMgbtXSGnjorm', TRUE);

INSERT INTO shared_documents (uuid, duid)
VALUES
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujsswThIGTUYm2K8FjOOfXtY1K'),
	('0000XSNJG0MQJHBF4QX1EFD6Y3', '0ujssxh0cECutqzMgbtXSGnjorm');

