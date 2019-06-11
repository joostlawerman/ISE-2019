-- +migrate Up
CREATE PROCEDURE SP_CREATE_TOURNAMENT
@chessclubname varchar(100),
@tournamentname varchar(100),
@contactname varchar(101),
@starts datetime,
@ends datetime = null,
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
		IF NOT EXISTS (SELECT 1 FROM CHESSCLUB WHERE @chessclubname = chessclubname)
			BEGIN
			RAISERROR('Chessclub is not known. Please register the chessclub first.', 16, 1)
			END
		ELSE IF NOT EXISTS (SELECT 1 FROM CONTACTPERSON WHERE @contactname = contactname)
			BEGIN
			RAISERROR('Contactperson is not known. Please register the contactperson first.', 16, 1)
			END
		ELSE
			BEGIN
			INSERT INTO TOURNAMENT (chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline) 
			VALUES (@chessclubname, @tournamentname, @contactname, @starts, @ends, @registrationfee, @addressline1, @postalcode, @city, @registrationdeadline)
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
DROP PROCEDURE SP_CREATE_TOURNAMENT;