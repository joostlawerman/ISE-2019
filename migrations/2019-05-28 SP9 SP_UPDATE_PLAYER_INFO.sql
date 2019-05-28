-- +migrate Up
CREATE PROC SP_UPDATE_PLAYER_INFO (
	@playerid int,
	@chessclubname varchar(100),
	@firstname varchar(50),
	@lastname varchar(50),
	@addressline1 varchar(100),
	@postalcode varchar(6),
	@city varchar(100),
	@birthdate date,
	@emailaddress varchar(256),
	@gender char(1)
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

		IF(@playerid IS NULL)
		BEGIN
			RAISERROR('Vul een playerid in.', 16, 1)
		END	


		IF(not exists (SELECT 1 
					   FROM PLAYER 
					   WHERE playerid = @playerid))
		BEGIN
			RAISERROR('De ingevulde speler bestaat niet.', 16, 1)
		END	

		IF(@chessclubname IS NULL)
		BEGIN
			RAISERROR('Vul een Chessclub in.', 16, 1)
		END	

		IF(not exists  (SELECT 1 
						FROM CHESSCLUB 
						WHERE chessclubname = @chessclubname))
			BEGIN
				RAISERROR('De ingevulde schaakclub bestaat niet.', 16, 1)
			END
		ELSE
			UPDATE PLAYER
			SET chessclubname = @chessclubname
			WHERE playerid = @playerid

		IF(@birthdate is not null)
		BEGIN
			IF(@birthdate > GETDATE())
				UPDATE PLAYER
				SET birthdate = @birthdate
				WHERE playerid = @playerid
			ELSE
				BEGIN
					RAISERROR('De datum van geboorte moet voor vandaag zijn.', 16, 1)
				END
		END
		
		IF(@firstname is not null)
		BEGIN
			UPDATE PLAYER
				SET firstname = @firstname
				WHERE playerid = @playerid
		END

		IF(@lastname is not null)
		BEGIN
			UPDATE PLAYER
				SET lastname = @lastname
				WHERE playerid = @playerid
		END


		IF(@addressline1 is not null)
		BEGIN
			UPDATE PLAYER
				SET addressline1 = @addressline1
				WHERE playerid = @playerid
		END

		IF(@postalcode is not null)
		BEGIN
			UPDATE PLAYER
				SET postalcode = @postalcode
				WHERE playerid = @playerid
		END

		IF(@city is not null)
		BEGIN
			UPDATE PLAYER
				SET city = @city
				WHERE playerid = @playerid
		END

		IF(@emailaddress is not null)
		BEGIN
			UPDATE PLAYER
				SET emailaddress = @emailaddress
				WHERE playerid = @playerid
		END

		IF(@gender is not null)
		BEGIN
			UPDATE PLAYER
				SET gender = @gender
				WHERE playerid = @playerid
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
DROP PROCEDURE SP_UPDATE_TOURNAMENT;