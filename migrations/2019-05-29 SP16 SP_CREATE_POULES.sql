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

-- +migrate Down
DROP PROC SP_CREATE_POULE_BASED_ON_CHESSCLUB;

-- +migrate Up
CREATE PROC SP_CREATE_POULE_BASED_ON_CHESSCLUB (
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
		
		IF NOT EXISTS(SELECT 1 FROM CHESSCLUB WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no chessclub with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(	SELECT 1 
							FROM CHESSMATCH_OF_POULE 
							WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber)
			BEGIN
				RAISERROR('There is no round with this roundnumber in this tournament', 16, 1)
			END

		SELECT tp.playerid, p.chessclubname
		INTO #TEMP_PLAYERS_IN_ROUND
		FROM TOURNAMENT_PLAYER tp INNER JOIN PLAYER p ON tp.playerid = p.playerid 
		WHERE tp.chessclubname = @chessclubname AND tp.tournamentname = @tournamentname

		CREATE TABLE #TEMP_CHESSCLUB_IN_ROUND(
			id int NOT NULL IDENTITY(1,1),
			chessclubname varchar(100) NOT NULL
		)
		
		INSERT INTO #TEMP_CHESSCLUB_IN_ROUND (chessclubname) SELECT DISTINCT chessclubname FROM #TEMP_PLAYERS_IN_ROUND
		
		DECLARE @currentChessclub int
		SET @currentChessclub = 1

		DECLARE @pouleno int
		SET @pouleno = 1

		DECLARE @maxPlayersPoule int
		SET @maxPlayersPoule = 4

		DECLARE @poulePlayer int

		WHILE ((SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) != 0)
		BEGIN
			IF EXISTS(SELECT 1 FROM #TEMP_PLAYERS_IN_ROUND WHERE chessclubname = (SELECT temp.chessclubname FROM #TEMP_CHESSCLUB_IN_ROUND temp WHERE id = @currentChessclub))
			BEGIN

				IF((SELECT COUNT(*) FROM TOURNAMENT_PLAYER_OF_POULE WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber AND pouleno = @pouleno) >= @maxPlayersPoule)
				BEGIN
					SET @pouleno = @pouleno + 1
					IF((SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) = 6 OR (SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) = 3 OR (SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) = 9)
					BEGIN
						SET @maxPlayersPoule = 3
					END
				END

				IF NOT EXISTS(SELECT 1 FROM POULE WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber AND pouleno = @pouleno)
				BEGIN
					INSERT INTO POULE VALUES (@chessclubname, @tournamentname, @roundnumber, @pouleno)
				END
		
				SET @poulePlayer = (SELECT TOP 1 playerid 
									FROM #TEMP_PLAYERS_IN_ROUND 
									WHERE chessclubname = (SELECT temp.chessclubname FROM #TEMP_CHESSCLUB_IN_ROUND temp WHERE id = @currentChessclub)
									ORDER BY NEWID())
				PRINT @poulePlayer
		
				INSERT INTO TOURNAMENT_PLAYER_OF_POULE 
					VALUES (@chessclubname, @poulePlayer, @tournamentname, @roundnumber, @pouleno)

				DELETE FROM #TEMP_PLAYERS_IN_ROUND WHERE playerid = @poulePlayer
			END
		
			IF(@currentChessclub = (SELECT TOP 1 id FROM #TEMP_CHESSCLUB_IN_ROUND ORDER BY id desc))
				BEGIN
					SET @currentChessclub = 1
				END
			ELSE
				BEGIN
					SET @currentChessclub = @currentChessclub + 1
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


