-- +migrate Down
DROP PROC SP_GET_POINTS_OF_PLAYER_FROM_ROUND;

-- +migrate Up
CREATE PROC SP_GET_POINTS_OF_PLAYER_FROM_ROUND (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@roundnumber int,
	@playerid int)
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
		IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END
		IF NOT EXISTS(	SELECT 1 
						FROM TOURNAMENT_ROUND
						WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber)
			BEGIN
				RAISERROR('There is no round with this roundnumber in this tournament', 16, 1)
			END	
		IF NOT EXISTS(SELECT 1 FROM CHESSMATCH_OF_POULE WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber < @roundnumber 
					AND ((playeridwhite = @playerid) OR (playeridblack = @playerid)))
			BEGIN
				RAISERROR('There is no player with this playerid in this round', 16, 1)
			END
		ELSE
			BEGIN
				SELECT @playerid AS playerid, (CAST(COUNT(*) AS DECIMAL) + (SELECT CAST(COUNT(*) AS DECIMAL)/2 
													FROM CHESSMATCH_OF_POULE 
													WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber < @roundnumber 
													AND ((playeridwhite = @playerid AND result = 'remise') 
													OR (playeridblack = @playerid AND result = 'remise')))) AS score
				FROM CHESSMATCH_OF_POULE 
				WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber < @roundnumber 
					AND ((playeridwhite = @playerid AND result = 'white') 
					OR (playeridblack = @playerid AND result = 'black'))	
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