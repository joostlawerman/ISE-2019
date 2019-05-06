-- +migrate Up
CREATE TABLE test(t int);

-- +migrate Down
DROP TABLE test;