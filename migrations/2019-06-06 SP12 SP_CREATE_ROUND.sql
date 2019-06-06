-- +migrate Down
DROP PROC SP_CREATE_ROUND;

-- +migrate Up
CREATE PROC SP_CREATE_ROUND (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@system varchar(25),
	@starts datetime,
	@ends datetime = NULL,
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
		IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE tournamentname = @tournamentname)
			BEGIN
				RAISERROR('There is no tournament with this name', 16, 1)
			END
		IF (@system != 'round robin')
			BEGIN
				RAISERROR('The system currently only supports round robin', 16, 1)
			END	
			
		DECLARE @roundnumber int = (ISNULL((SELECT TOP 1 roundnumber FROM TOURNAMENT_ROUND WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname ORDER BY roundnumber DESC),  0)) + 1

		INSERT INTO TOURNAMENT_ROUND
		VALUES (@chessclubname, @tournamentname, @roundnumber, @system, @starts, @ends)

		EXEC SP_CREATE_POULES @chessclubname, @tournamentname, @roundnumber, @isFinal
				
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