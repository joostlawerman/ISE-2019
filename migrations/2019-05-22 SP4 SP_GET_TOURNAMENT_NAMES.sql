-- +migrate Down
DROP PROCEDURE SP_GET_TOURNAMENT_NAMES;

-- +migrate Up
CREATE PROCEDURE SP_GET_TOURNAMENT_NAMES
        @chessclubname VARCHAR(100)
AS
    BEGIN
        DECLARE @orginTranCount INT
        SET @orginTranCount = @@TRANCOUNT
        IF @orginTranCount > 0
            SAVE TRANSACTION ProcedureSave
        ELSE
            BEGIN TRANSACTION
        BEGIN TRY
        IF @chessclubname IS NULL OR NOT EXISTS(SELECT 1 FROM chessclub WHERE chessclubname = @chessclubname)
            SELECT chessclubname, tournamentname
            FROM TOURNAMENT
        ELSE
            SELECT chessclubname, tournamentname
            FROM TOURNAMENT
            WHERE chessclubname = @chessclubname
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
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
        END CATCH
    END;
