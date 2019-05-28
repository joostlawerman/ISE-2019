-- +migrate Down
DROP PROCEDURE SP_GET_POULES_OF_ROUND;

-- +migrate Up
CREATE PROCEDURE SP_GET_POULES_OF_ROUND
@chessclubname varchar(100),
@tournamentname varchar(100),
@roundnumber int
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
		ELSE IF NOT EXISTS(	SELECT 1 
							FROM TOURNAMENT_ROUND 
							WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname AND roundnumber = @roundnumber)
			BEGIN
				RAISERROR('There is no round with this roundnumber in this tournament', 16, 1)
			END
			
		SELECT * FROM POULE WHERE @chessclubname = chessclubname AND @tournamentname = tournamentname AND @roundnumber = roundnumber
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
