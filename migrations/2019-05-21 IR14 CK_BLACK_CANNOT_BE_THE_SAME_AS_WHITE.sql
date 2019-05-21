-- +migrate Up
ALTER TABLE CHESSMATCH
    ADD CONSTRAINT CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE CHECK (NOT playeridblack = playeridwhite);

-- +migrate Down
ALTER TABLE CHESSMATCH
    DROP CONSTRAINT CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE;