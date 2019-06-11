-- +migrate Up
CREATE TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED
    ON TOURNAMENT_PLAYER_OF_POULE
    AFTER INSERT, UPDATE
AS
    IF @@ROWCOUNT = 0
        RETURN

SET NOCOUNT ON
BEGIN TRY
IF EXISTS(SELECT 1
          FROM Inserted i
          WHERE EXISTS(
              SELECT 1
              FROM POULE p INNER JOIN CHESSMATCH_OF_POULE c
                      ON p.pouleno = c.pouleno AND p.roundnumber = c.roundnumber AND p.chessclubname = c.chessclubname
                         AND p.tournamentname = c.tournamentname
              WHERE (p.pouleno = i.pouleno AND p.roundnumber = i.roundnumber AND p.chessclubname = i.chessclubname AND
                     p.tournamentname = i.tournamentname) OR c.result IS NULL))

    BEGIN
        THROW 50000, 'A poule can not be changed when a match in that poule has started', 1
    END
END TRY
BEGIN CATCH
THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED;