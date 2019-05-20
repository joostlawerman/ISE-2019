-- +migrate Up
ALTER TABLE PLAYER
    ALTER COLUMN birthdate DATE;
