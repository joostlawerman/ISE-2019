/*
	- Specificatie: Een match tussen twee spelers mag niet twee keer plaatsvinden binnen een round robin poule. 
	- Implementatie: trigger TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE op de tabellen “CHESSMATCH” en “ROUND_ROBIN_POULE”.

	moet triggeren zodra:
	- insert: CHESSMATCH krijgt een nieuwe match
	- update: match wordt aangepast

*/

-- +migrate Up
CREATE TRIGGER TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE
    ON CHESSMATCH
    AFTER INSERT, UPDATE
    AS
    BEGIN
        BEGIN
          IF @@ROWCOUNT = 0
        RETURN
            BEGIN TRY

				SELECT C.MATCHNO, C.playeridblack, C.playeridwhite
				FROM CHESSMATCH C INNER JOIN CHESSMATCH CH ON C.matchno = CH.matchno
				WHERE C.playeridblack = CH.playeridblack AND C.playeridwhite = CH.playeridwhite

			END TRY
            BEGIN CATCH
				THROW
            END CATCH
        END
    END
;

-- +migrate Down
DROP TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END
;

