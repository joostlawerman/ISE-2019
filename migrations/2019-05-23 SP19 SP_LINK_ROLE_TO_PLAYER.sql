-- +migrate Up
CREATE PROC SP_LINK_ROLE_TO_PLAYER 
	@playerid int,
	@chessclubname varchar(100),
	@role varchar(50)
AS
BEGIN
	DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0    
        SAVE TRANSACTION ProcedureSave  
    ELSE  
        BEGIN TRANSACTION  
	BEGIN TRY		
		
		IF NOT EXISTS(SELECT 1 FROM PLAYER WHERE playerid = @playerid)
			BEGIN
				RAISERROR('This playerid does not exist', 16, 1)
			END
		
		IF NOT EXISTS(SELECT 1 FROM CHESSCLUB WHERE chessclubname = @chessclubname)
			BEGIN
				RAISERROR('This chessclub does not exist', 16, 1)
			END
		
		IF EXISTS(SELECT 1 FROM ROLE WHERE playerid = @playerid AND chessclubname = @chessclubname AND role = @role)
			BEGIN
				RAISERROR('This player already has this role in the chosen chessclub', 16, 1)
			END	
		ELSE
			BEGIN
				INSERT INTO ROLE (playerid, chessclubname, role)
				VALUES (@playerid, @chessclubname, @role) 
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
DROP PROC SP_LINK_ROLE_TO_PLAYER;