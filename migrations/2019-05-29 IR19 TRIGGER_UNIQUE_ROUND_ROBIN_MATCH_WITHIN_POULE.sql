-- +migrate Up
CREATE TRIGGER TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE
    ON CHESSMATCH_OF_POULE
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY

        IF EXISTS(SELECT 1
                  FROM inserted cp
                      INNER JOIN inserted i ON cp.tournamentname = i.tournamentname AND
                                               cp.chessclubname = i.chessclubname AND
                                               cp.roundnumber = i.roundnumber AND
                                               cp.pouleno = i.pouleno AND
                                               i.playeridblack IN (cp.playeridblack, cp.playeridwhite) AND
                                               i.playeridwhite IN (cp.playeridblack, cp.playeridwhite)
                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                        tr.chessclubname = i.chessclubname AND
                                                        tr.roundnumber = i.roundnumber
                  WHERE (cp.playeridwhite < cp.playeridblack OR cp.playeridwhite > cp.playeridblack) AND
                        tr.system = 'round robin'
                  HAVING count(*) > 1)
            BEGIN
                THROW 50001, 'The inserted values have a duplicate match in this round robin poule', 1
            END

        /**
            Check of een nieuwe rij geen duplicate heeft met al bestaande rijen
         */
        IF EXISTS(SELECT 1
                  FROM CHESSMATCH_OF_POULE cp
                      INNER JOIN inserted i ON cp.tournamentname = i.tournamentname AND
                                               cp.chessclubname = i.chessclubname AND
                                               cp.roundnumber = i.roundnumber AND
                                               cp.pouleno = i.pouleno AND
                                               i.playeridblack IN (cp.playeridblack, cp.playeridwhite) AND
                                               i.playeridwhite IN (cp.playeridblack, cp.playeridwhite)
                      INNER JOIN TOURNAMENT_ROUND tr ON tr.tournamentname = i.tournamentname AND
                                                        tr.chessclubname = i.chessclubname AND
                                                        tr.roundnumber = i.roundnumber
                  WHERE (cp.playeridwhite < cp.playeridblack OR cp.playeridwhite > cp.playeridblack) AND
                        tr.system = 'round robin')
            BEGIN
                THROW 50001, 'One of the matches that are inserted already exists in this round robin poule', 1
            END

        END TRY
        BEGIN CATCH
        THROW
        END CATCH
    END;

-- +migrate Down
DROP TRIGGER TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE;

