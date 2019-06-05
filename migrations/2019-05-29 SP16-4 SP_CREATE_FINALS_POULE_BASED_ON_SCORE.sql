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
BEGIN TRAN
	DELETE FROM CHESSMATCH_OF_POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_PLAYER_OF_POULE WHERE roundnumber > 1
	DELETE FROM ROUND_ROBIN_POULE WHERE roundnumber > 1
	DELETE FROM POULE WHERE roundnumber > 1
	DELETE FROM TOURNAMENT_ROUND WHERE roundnumber > 2
	EXEC SP_CREATE_FINALS_POULE_BASED_ON_SCORE 'Tilburg', 'Tilburger Toernooi', 2
	SELECT * FROM TOURNAMENT_PLAYER_OF_POULE where roundnumber = 2 order by roundnumber, pouleno
ROLLBACK TRAN
*/

-- +migrate Down
DROP PROC SP_CREATE_FINALS_POULE_BASED_ON_SCORE;

-- +migrate Up
CREATE PROC SP_CREATE_FINALS_POULE_BASED_ON_SCORE (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@roundnumber int)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY
		
		SELECT tp.playerid
		INTO #TEMP_PLAYERS_IN_ROUND
		FROM TOURNAMENT_PLAYER tp INNER JOIN PLAYER p ON tp.playerid = p.playerid 
		WHERE tp.chessclubname = @chessclubname AND tp.tournamentname = @tournamentname
		
		CREATE TABLE #TEMP_PLAYER_SCORE_IN_ROUND(
			playerid int,
			score decimal(5,2) 
		)

		DECLARE @currentPlayer int
		DECLARE @roundnumberOfLastRound int
		SET @roundnumberOfLastRound = @roundnumber

		WHILE ((SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) != 0)
		BEGIN
			SET @currentPlayer = (SELECT TOP 1 playerid FROM #TEMP_PLAYERS_IN_ROUND)
			INSERT INTO #TEMP_PLAYER_SCORE_IN_ROUND EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND @chessclubname, @tournamentname, @roundnumberOfLastRound, @currentPlayer
			DELETE FROM #TEMP_PLAYERS_IN_ROUND WHERE playerid = @currentPlayer
		END

		DECLARE @pouleno int
		SET @pouleno = 1

		DECLARE @maxPlayersPoule int
		SET @maxPlayersPoule = 8

		IF((SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 7 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 14 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 21 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 28 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 35 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 42 
			OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 49)
		BEGIN
			SET @maxPlayersPoule = 7
		END

		DECLARE @poulePlayer int
		
		WHILE ((SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) != 0)
		BEGIN
			--Check if there are max players in a poule
			IF((SELECT COUNT(*) FROM TOURNAMENT_PLAYER_OF_POULE WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber AND pouleno = @pouleno) >= @maxPlayersPoule)
			BEGIN
				SET @pouleno = @pouleno + 1

				DECLARE @NUMMER INT
				SET @NUMMER = (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND)
				PRINT @NUMMER
				--Check if max players in poule is still valid
				IF((SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 7 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 14 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 21 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 28 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 35 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 42 
					OR (SELECT COUNT(*) FROM #TEMP_PLAYER_SCORE_IN_ROUND) = 49)
				BEGIN
					SET @maxPlayersPoule = 7
				END
			END

			--Check if poule not exists
			IF NOT EXISTS(SELECT 1 FROM POULE WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber AND pouleno = @pouleno)
			BEGIN
				INSERT INTO POULE VALUES (@chessclubname, @tournamentname, @roundnumber, @pouleno)
			END
		
			SET @poulePlayer = (SELECT TOP 1 playerid 
								FROM #TEMP_PLAYER_SCORE_IN_ROUND
								ORDER BY score DESC, NEWID())

			INSERT INTO TOURNAMENT_PLAYER_OF_POULE 
				VALUES (@chessclubname, @poulePlayer, @tournamentname, @roundnumber, @pouleno)

			DELETE FROM #TEMP_PLAYER_SCORE_IN_ROUND WHERE playerid = @poulePlayer
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