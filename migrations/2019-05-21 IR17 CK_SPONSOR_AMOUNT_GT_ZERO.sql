-- +migrate Up
ALTER TABLE SPONSOR
    ADD CONSTRAINT CK_SPONSOR_AMOUNT_GT_ZERO CHECK (sponsoramount > 0);

-- +migrate Down
ALTER TABLE SPONSOR
    DROP CONSTRAINT CK_SPONSOR_AMOUNT_GT_ZERO;
