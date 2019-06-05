-- +migrate Up
CREATE PROCEDURE SP_CREATE_PLAYER
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
		IF NOT EXISTS (SELECT 1 FROM CHESSCLUB WHERE @chessclubname = chessclubname)
			BEGIN
			RAISERROR('Chessclub is not known. Please register the chessclub first.', 16, 1)
			END

		DECLARE @playerid int
		SELECT @playerid = (SELECT TOP 1 playerid FROM PLAYER ORDER BY playerid DESC) + 1
		IF (@playerid IS NULL)
			SELECT @playerid = 1

		INSERT INTO PLAYER VALUES (@playerid, @chessclubname, @firstname, @lastname, @addressline1, @postalcode, @city, @birthdate, @email, @gender)
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
DROP PROCEDURE SP_CREATE_PLAYER;