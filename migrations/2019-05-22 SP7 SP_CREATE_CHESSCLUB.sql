-- +migrate Up
CREATE PROC SP_CREATE_CHESSCLUB (
	@chessclubname varchar(100),
	@city varchar(100),
	@addressline1 varchar(100),
	@postalcode varchar(6),
	@emailaddress varchar(256))
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY	
		IF EXISTS (SELECT 1 FROM CHESSCLUB WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('There already is a chessclub with the same name', 16, 1)
			END	
		ELSE	
			BEGIN
				INSERT INTO CHESSCLUB (chessclubname, city, addressline1, postalcode, emailaddress)
				VALUES (@chessclubname,	@city, @addressline1, @postalcode, @emailaddress)
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
DROP PROC SP_CREATE_CHESSCLUB;