-- +migrate Up
ALTER TABLE TOURNAMENT
ADD CONSTRAINT CHK_REGISTRATION_FEE_GTE_ZERO CHECK (registrationfee >= 0.00)
GO
;