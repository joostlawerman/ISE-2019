-- +migrate Down
DROP PROCEDURE SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT;

-- +migrate Up
CREATE PROCEDURE SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT
@chessclubname varchar(100),
@tournamentname varchar(100),
@playerid int
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no chessclub with this name', 16, 1)
			END
		
		IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END

		IF NOT EXISTS(SELECT 1 FROM PLAYER WHERE playerid = @playerid)
			BEGIN
				RAISERROR('The playerid does not exists', 16, 1)
			END
		
		IF EXISTS (SELECT 1 FROM TOURNAMENT_PLAYER WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname AND playerid = @playerid)
			BEGIN
				SELECT playerid,1,paid 
				FROM TOURNAMENT_PLAYER
				WHERE tournamentname = @tournamentname AND 
					  chessclubname = @chessclubname AND 
					  playerid = @playerid
			END
		ELSE 
			BEGIN
				SELECT playerid,0,0 
				FROM PLAYER
				WHERE playerid = @playerid
			END
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

