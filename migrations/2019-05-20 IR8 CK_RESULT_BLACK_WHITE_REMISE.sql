-- +migrate Up
ALTER TABLE CHESSMATCH
    ADD CONSTRAINT CK_RESULT_BLACK_WHITE_REMISE CHECK (result IS NULL OR (result = 'black' OR result = 'white' OR result = 'remise'));

-- +migrate Down
ALTER TABLE CHESSMATCH
    DROP CONSTRAINT CK_RESULT_BLACK_WHITE_REMISE;

