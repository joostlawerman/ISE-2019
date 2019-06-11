-- +migrate Down
DROP PROC SP_UPDATE_PLAYER_PARTICIPATES;

-- +migrate Up
CREATE PROC SP_UPDATE_PLAYER_PARTICIPATES (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@playerid int,
	@participates bit)
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
		IF NOT EXISTS(SELECT 1 FROM PLAYER WHERE playerid = @playerid)
			BEGIN
				RAISERROR('There is no player with this playerid', 16, 1)
			END
		
		IF(@participates = 0)
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM TOURNAMENT_PLAYER WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND playerid = @playerid)
					BEGIN
						RAISERROR('This player is already not participating', 16, 1)
					END
				ELSE 
					BEGIN
						DELETE FROM TOURNAMENT_PLAYER 
						WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND playerid = @playerid
					END
			END
		IF(@participates = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM TOURNAMENT_PLAYER WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND playerid = @playerid)
					BEGIN
						RAISERROR('This player is already participating', 16, 1)
					END
				ELSE 
					BEGIN
						INSERT INTO TOURNAMENT_PLAYER 
						VALUES (@chessclubname, @tournamentname, @playerid, 0)
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