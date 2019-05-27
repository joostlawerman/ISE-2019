-- +migrate Up
CREATE PROC SP_UPDATE_TOURNAMENT (
	@chessclubname varchar(100),
	@tournamentname varchar(100),
	@winner int,
	@contactname varchar(100),
	@starts datetime,
	@ends datetime,
	@registrationfee money,
	@addressline1 varchar(100),
	@postalcode varchar(6),
	@city varchar(100),
	@registrationdeadline datetime
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

		IF(@contactname is not null)
		BEGIN
			IF(exists (SELECT 1
					   FROM CONTACTPERSON
					   WHERE contactname = @contactname))
				BEGIN
					UPDATE TOURNAMENT
					SET contactname = @contactname
					WHERE chessclubname = @chessclubname and
						  tournamentname = @tournamentname;	
				END	
			ELSE
				BEGIN
					RAISERROR('Het ingevulde contactpersoon bestaat niet.', 16, 1)
				END	
	    END	
		
		IF(@winner is not null)
		BEGIN

			IF(not exists (SELECT 1
						   FROM PLAYER
						   WHERE playerid = @winner))
			BEGIN
				RAISERROR('De ingevulde winnaar is geen bestaande speler.', 16, 1)
			END
						
			IF(exists (SELECT 1
					   FROM TOURNAMENT_PLAYER
					   WHERE chessclubname = @chessclubname AND
							 tournamentname = @tournamentname AND
							 playerid = @winner))
				BEGIN
					UPDATE TOURNAMENT
					SET winner = @winner
					WHERE chessclubname = @chessclubname and
						  tournamentname = @tournamentname;	
				END	
			ELSE
				BEGIN
					RAISERROR('De ingevulde winnaar doet niet mee aan het geselecteerde toernooi.', 16, 1)
				END
	    END

		IF(@starts is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET starts = @starts
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END

		IF(@ends is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET ends = @ends
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END
	
		IF(@registrationfee is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET registrationfee = @registrationfee
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END
		
		IF(@addressline1 is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET addressline1 = @addressline1
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END

		IF(@postalcode is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET postalcode = @postalcode
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END

		IF(@city is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET city = @city
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
		END

		IF(@registrationdeadline is not null)
		BEGIN
			UPDATE TOURNAMENT
			SET registrationdeadline = @registrationdeadline
			WHERE chessclubname = @chessclubname and
				  tournamentname = @tournamentname;	
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