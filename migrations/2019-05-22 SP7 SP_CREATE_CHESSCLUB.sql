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
	END CATCH
END;

-- +migrate Down
DROP PROC SP_CREATE_CHESSCLUB;