-- Specification of postal codes in the netherlands https://nl.wikipedia.org/wiki/Postcodes_in_Nederland
-- 1. Format should be '[0-9][0-9][0-9][0-9][A-Z][A-Z]'
-- 2. First four digits should be >= 1000
-- 3. Last two digits may not contain ('SS', 'SD', 'SA')

-- +migrate Up 
ALTER TABLE TOURNAMENT
    ADD CONSTRAINT CK_TOURNAMENT_POSTCODE_VALID CHECK (
        postalcode LIKE '[0-9][0-9][0-9][0-9][A-Z][A-Z]'
        AND CONVERT(INT, SUBSTRING(postalcode, 1,4)) >= 1000
        AND SUBSTRING(postalcode, 5, 6) not in ('SS', 'SD', 'SA')
    )
;

-- +migrate Down
ALTER TABLE TOURNAMENT
    DROP CONSTRAINT CK_TOURNAMENT_POSTCODE_VALID
;

-- +migrate Up 
ALTER TABLE CHESSCLUB
    ADD CONSTRAINT CK_CHESSCLUB_POSTCODE_VALID CHECK (
        postalcode LIKE '[0-9][0-9][0-9][0-9][A-Z][A-Z]'
        AND CONVERT(INT, SUBSTRING(postalcode, 1,4)) >= 1000
        AND SUBSTRING(postalcode, 5, 6) not in ('SS', 'SD', 'SA')
    )
;

-- +migrate Down
ALTER TABLE CHESSCLUB
    DROP CONSTRAINT CK_CHESSCLUB_POSTCODE_VALID
;

-- +migrate Up 
ALTER TABLE PLAYER
    ADD CONSTRAINT CK_PLAYER_POSTCODE_VALID CHECK (
        postalcode LIKE '[0-9][0-9][0-9][0-9][A-Z][A-Z]'
            AND CONVERT(INT, SUBSTRING(postalcode, 1,4)) >= 1000
            AND SUBSTRING(postalcode, 5, 6) not in ('SS', 'SD', 'SA')
    )
;

-- +migrate Down
ALTER TABLE PLAYER
    DROP CONSTRAINT CK_PLAYER_POSTCODE_VALID
;
