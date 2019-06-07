-- +migrate Up
CREATE PROC SP_UPDATE_TOURNAMENT_PLAYER_PAID (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@playerid int,
	@paid bit)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY		
		
		IF NOT EXISTS(SELECT 1 FROM PLAYER WHERE playerid = @playerid)
			BEGIN
				RAISERROR('This playerid does not exist', 16, 1)
			END
		IF NOT EXISTS(SELECT 1 FROM CHESSCLUB WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no chessclub with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END
		ELSE IF NOT EXISTS(	SELECT 1 
							FROM TOURNAMENT_PLAYER 
							WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND playerid = @playerid)
			BEGIN
				RAISERROR('This player is not participating in this tournament', 16, 1)
			END	
		ELSE
			BEGIN
				UPDATE TOURNAMENT_PLAYER
					SET paid = @paid
					WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND playerid = @playerid
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

-- +migrate Down
DROP PROC SP_UPDATE_TOURNAMENT_PLAYER_PAID;