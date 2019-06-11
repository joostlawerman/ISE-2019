-- +migrate Up 
CREATE TABLE AUDITLOG (
	tablename VARCHAR(26) NOT NULL,
	[user] VARCHAR(25) NOT NULL,
	[action] VARCHAR(255) NOT NULL,
	[timestamp] DATETIME NOT NULL
);

-- +migrate Down
DROP TABLE AUDITLOG;