-- +migrate Up
CREATE PROCEDURE GET_TOURNAMENT_INFO
@tournamentname varchar(100),
@chessclubname varchar(100)
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
		SELECT * FROM TOURNAMENT WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname
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
DROP PROCEDURE GET_TOURNAMENT_INFO;