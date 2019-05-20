-- +migrate Up 
ALTER TABLE TOURNAMENT
    ADD CONSTRAINT CK_START_GT_NOW CHECK (starts > getdate())
;

-- +migrate Down
ALTER TABLE emp
    DROP CONSTRAINT CK_START_GT_NOW
;


