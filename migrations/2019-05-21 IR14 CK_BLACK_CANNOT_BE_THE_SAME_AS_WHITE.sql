-- +migrate Up
ALTER TABLE CHESSMATCH_OF_POULE
    ADD CONSTRAINT CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE CHECK (NOT playeridblack = playeridwhite);

-- +migrate Down
ALTER TABLE CHESSMATCH_OF_POULE
    DROP CONSTRAINT CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE;
