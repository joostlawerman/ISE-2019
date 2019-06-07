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

