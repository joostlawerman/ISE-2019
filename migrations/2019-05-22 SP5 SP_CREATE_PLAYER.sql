-- +migrate Up
CREATE PROCEDURE SP_CREATE_PLAYER
@playerid int,
@chessclubname varchar(100),
@firstname varchar(50),
@lastname varchar(50),
@addressline1 varchar(100),
@postalcode varchar(6),
@city varchar(100),
@birthdate date,
@email varchar(256),
@gender char(1)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION
	BEGIN TRY		
		INSERT INTO PLAYER VALUES (@playerid, @chessclubname, @firstname, @lastname, @addressline1, @postalcode, @city, @birthdate, @email, @gender)
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
DROP PROCEDURE SP_CREATE_PLAYER;