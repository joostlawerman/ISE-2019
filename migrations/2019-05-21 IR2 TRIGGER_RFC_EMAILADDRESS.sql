-- Specification of email addresses https://en.wikipedia.org/wiki/Email_address
-- 1. Local part is a maximum of 64 characters long 
-- 2. There is only 1 '@' in the address
-- 3. The email adress contains only these kind of characters
---  a. Lowercase
--   b. Numeric
--   c. `@,.,+,0-9,_,\-`
-- 4. The email address should be formated as [local-part]@[domain].[extension]

-- +migrate Up
ALTER TABLE PLAYER
    ALTER COLUMN emailaddress VARCHAR(255)
;

-- +migrate Up
ALTER TABLE PLAYER
    ADD CONSTRAINT TRIGGER_PLAYER_RFC_EMAILADDRESS CHECK (
        CHARINDEX('@', emailaddress) <= 64
            AND len(emailaddress) - len(replace(emailaddress, '@', '')) = 1
            AND PATINDEX('%[^a-z,@,.,+,0-9,_,\-]%', emailaddress) = 0
            AND emailaddress LIKE '%_@_%.__%'
    )
;

-- +migrate Down
ALTER TABLE PLAYER
    DROP CONSTRAINT TRIGGER_PLAYER_RFC_EMAILADDRESS
;

-- +migrate Up
ALTER TABLE CHESSCLUB
    ALTER COLUMN emailaddress VARCHAR(255)
;

-- +migrate Up
ALTER TABLE CHESSCLUB
    ADD CONSTRAINT TRIGGER_CHESSCLUB_RFC_EMAILADDRESS CHECK (
        CHARINDEX('@', emailaddress) <= 64
            AND len(emailaddress) - len(replace(emailaddress, '@', '')) = 1
            AND PATINDEX('%[^a-z,@,.,+,0-9,_,\-]%', emailaddress) = 0
            AND emailaddress LIKE '%_@_%.__%'
    )
;

-- +migrate Down
ALTER TABLE CHESSCLUB
    DROP CONSTRAINT TRIGGER_CHESSCLUB_RFC_EMAILADDRESS
;

-- +migrate Up
ALTER TABLE CONTACTPERSON
    ALTER COLUMN emailaddress VARCHAR(255)
;

-- +migrate Up
ALTER TABLE CONTACTPERSON
    ADD CONSTRAINT TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS CHECK (
        CHARINDEX('@', emailaddress) <= 64
            AND len(emailaddress) - len(replace(emailaddress, '@', '')) = 1
            AND PATINDEX('%[^a-z,@,.,+,0-9,_,\-]%', emailaddress) = 0
            AND emailaddress LIKE '%_@_%.__%'
    )
;

-- +migrate Down
ALTER TABLE CONTACTPERSON
    DROP CONSTRAINT TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS
;
