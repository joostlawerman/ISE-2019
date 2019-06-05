-- +migrate Up 
CREATE TABLE AUDITLOG (
    audit VARCHAR(255) NOT NULL
);

-- +migrate Down
DROP TABLE AUDITLOG;