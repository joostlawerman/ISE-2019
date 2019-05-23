-- +migrate Up
CREATE PROCEDURE SP_CREATE_TOURNAMENT
@chessclubname varchar(100),
@tournamentname varchar(100),
@contactname varchar(101),
@starts datetime,
@ends datetime,
@registrationfee money,
@addressline1 varchar(100),
@postalcode varchar(6),
@city varchar(100),
@registrationdeadline datetime
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION
	BEGIN TRY		
		INSERT INTO TOURNAMENT (chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline) 
		VALUES (@chessclubname, @tournamentname, @contactname, @starts, @ends, @registrationfee, @addressline1, @postalcode, @city, @registrationdeadline)
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
DROP PROCEDURE SP_CREATE_TOURNAMENT;