-- +migrate Up
CREATE TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED
ON TOURNAMENT_PLAYER_OF_POULE
AFTER INSERT, UPDATE
AS
IF @@ROWCOUNT = 0
    RETURN
        
SET NOCOUNT ON
BEGIN TRY
			IF EXISTS (	SELECT 1
						FROM Inserted i INNER JOIN TOURNAMENT_PLAYER_OF_POULE t ON i.pouleno = t.pouleno AND i.roundnumber = t.roundnumber
						WHERE EXISTS(
									SELECT 1
									FROM POULE p INNER JOIN CHESSMATCH_OF_POULE c ON p.pouleno = c.pouleno AND i.roundnumber = t.roundnumber
									WHERE (p.pouleno = t.pouleno AND i.roundnumber = t.roundnumber) OR c.result IS NULL))

      		BEGIN
              	   THROW 50000, 'A poule can not be changed when a match in that poule has started', 1
      		END
END TRY
BEGIN CATCH
   	THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED;