-- +migrate Up
CREATE OR ALTER TRIGGER TRIGGER_MIN_THREE_YEARS_OLD
ON TOURNAMENT_PLAYER
AFTER INSERT, UPDATE
AS

IF @@ROWCOUNT = 0
	RETURN
        
SET NOCOUNT ON

BEGIN TRY
	IF NOT EXISTS(SELECT 1 FROM inserted i WHERE (
			 (SELECT p.birthdate FROM PLAYER p WHERE p.playerid = i.playerid) 
			 <=
			 (SELECT DATEADD(YEAR, -3, t.starts) FROM TOURNAMENT t WHERE t.tournamentname = i.tournamentname AND t.chessclubname = i.chessclubname)))
		THROW 50005, 'A participant has to be 3 years old when te tournament starts.', 1
END TRY
BEGIN CATCH
	THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_MIN_THREE_YEARS_OLD;