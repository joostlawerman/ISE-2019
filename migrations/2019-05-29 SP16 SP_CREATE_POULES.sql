-- +migrate Down
DROP PROC SP_CREATE_POULES;

-- +migrate Up
CREATE PROC SP_CREATE_POULES (
	@variabele numeric(4))
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY		
		
		IF(/*voorwaarde, als die er is*/)
			BEGIN
				RAISERROR('error message', 16, 1)
			END	
		ELSE
			BEGIN
				INSERT INTO tablename ()
				VALUES () 
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