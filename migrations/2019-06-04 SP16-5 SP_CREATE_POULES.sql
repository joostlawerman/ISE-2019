/*
- kijken naar hoeveel spelers er in de ronde zitten.
- kijken wat voor systeem het is.
- kijken of het de eerste ronde is (round robin)
- bij eerste ronde indelen dat spelers zoveel mogelijk in andere schaakclubs zitten.
- bij een vervolg ronde indelen op punten ronde ervoor.(round robin)
- kijken of het een finale ronde is (round robin)
- bij een finale ronde poules van 8 personen (7 bij oneven)
- kijken of er oneven poules zijn
*/

/*
--Eerste ronde
BEGIN TRAN
	DELETE FROM CHESSMATCHMOVE
	DELETE FROM CHESSMATCH_OF_POULE
	DELETE FROM TOURNAMENT_PLAYER_OF_POULE
	DELETE FROM ROUND_ROBIN_POULE
	DELETE FROM POULE
	DELETE FROM TOURNAMENT_ROUND WHERE roundnumber > 1

	EXEC SP_CREATE_POULES 'Tilburg', 'Tilburger Toernooi', 1, 0

	SELECT t.tournamentname, p.chessclubname, p.playerid, t.roundnumber, t.pouleno 
	FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid 
	WHERE t.chessclubname = 'Tilburg' AND tournamentname = 'Tilburger Toernooi' AND RoundNumber = 1 
	ORDER BY t.pouleno

	SELECT count(a.b) FROM(
	SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 3) AS a
ROLLBACK TRAN

--Normale ronde
BEGIN TRAN
	DELETE FROM CHESSMATCH_OF_POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_PLAYER_OF_POULE WHERE roundnumber > 1
	DELETE FROM ROUND_ROBIN_POULE WHERE roundnumber > 1
	DELETE FROM POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_ROUND WHERE roundnumber > 2

	EXEC SP_CREATE_POULES 'Tilburg', 'Tilburger Toernooi', 2, 0

	SELECT t.tournamentname, p.chessclubname, p.playerid, t.roundnumber, t.pouleno 
	FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid 
	WHERE t.chessclubname = 'Tilburg' AND tournamentname = 'Tilburger Toernooi' AND RoundNumber = 1 
	ORDER BY t.pouleno
ROLLBACK TRAN

--Laatste ronde
BEGIN TRAN
	DELETE FROM CHESSMATCH_OF_POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_PLAYER_OF_POULE WHERE roundnumber > 1
	DELETE FROM ROUND_ROBIN_POULE WHERE roundnumber > 1
	DELETE FROM POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_ROUND WHERE roundnumber > 2

	EXEC SP_CREATE_POULES 'Tilburg', 'Tilburger Toernooi', 2, 1

	SELECT * FROM TOURNAMENT_PLAYER_OF_POULE where roundnumber = 2 order by roundnumber, pouleno
ROLLBACK TRAN
*/

-- +migrate Down
DROP PROC SP_CREATE_POULES;

-- +migrate Up
CREATE PROC SP_CREATE_POULES (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@roundnumber int,
	@isFinal bit)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY
		
		IF NOT EXISTS(SELECT 1 FROM CHESSCLUB WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no chessclub with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(SELECT 1 FROM TOURNAMENT_ROUND WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber)
			BEGIN
				RAISERROR('There is no round with this number in this tournament', 16, 1)
			END

		IF ((SELECT system 
			 FROM TOURNAMENT_ROUND 
			 WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber) != 'round robin')
			BEGIN
				RAISERROR('The system currently only supports round robin', 16, 1)
			END
		ELSE IF ((SELECT system 
				  FROM TOURNAMENT_ROUND 
			      WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber) = 'round robin')
			BEGIN
				IF(@roundnumber = 1 AND @isFinal = 0)
					BEGIN
						EXEC SP_CREATE_POULE_BASED_ON_CHESSCLUB @chessclubname,	@tournamentname, @roundnumber
					END
				ELSE IF(@isFinal = 1)
					BEGIN
						EXEC SP_CREATE_FINALS_POULE_BASED_ON_SCORE @chessclubname,	@tournamentname, @roundnumber
					END
				ELSE
					BEGIN
						EXEC SP_CREATE_POULE_BASED_ON_SCORE @chessclubname,	@tournamentname, @roundnumber
					END
			END
				
        IF @orginTranCount = 0  
            COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
		IF @orginTranCount = 0  
            ROLLBACK TRANSACTION  
        ELSE  
			IF XACT_STATE() <> -1  
            ROLLBACK TRANSACTION ProcedureSave  
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END;

