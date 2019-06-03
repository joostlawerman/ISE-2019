-- +migrate Up
CREATE PROC SP_UPDATE_TOURNAMENT_ENDDATE (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@ends datetime
	)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY		

		IF(@chessclubname IS NULL or @tournamentname IS NULL)
			BEGIN
				RAISERROR('Vul een schaakclub en toernooinaam in.', 16, 1)
			END	
		
		IF(not exists (SELECT 1 
					   FROM CHESSCLUB 
					   WHERE chessclubname = @chessclubname))
			BEGIN
				RAISERROR('De ingevulde schaakclub bestaat niet.', 16, 1)
			END	

		IF(not exists (SELECT 1 
					   FROM CHESSCLUB C INNER JOIN TOURNAMENT T ON C.chessclubname = T.chessclubname 
					   WHERE C.chessclubname = @chessclubname AND T.tournamentname = @tournamentname))
			BEGIN
				RAISERROR('Het ingevulde schaaktoernooi voor de ingevulde schaakclub bestaat niet.', 16, 1)
			END	

		IF(@ends IS NOT NULL and (	SELECT starts 
									FROM TOURNAMENT 
									WHERE chessclubname = @chessclubname AND tournamentname = @tournamentname) > @ends)
			BEGIN
				RAISERROR('De ingevulde eindtijd moet na de begintijd zijn.', 16, 1)
			END


		BEGIN
		UPDATE TOURNAMENT
			SET ends = @ends
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname	
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
DROP PROCEDURE SP_UPDATE_TOURNAMENT_ENDDATE;