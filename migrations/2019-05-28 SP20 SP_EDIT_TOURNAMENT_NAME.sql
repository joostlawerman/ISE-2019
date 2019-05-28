-- +migrate Down
DROP PROCEDURE SP_EDIT_TOURNAMENT_NAME;

-- +migrate Up
CREATE PROCEDURE SP_EDIT_TOURNAMENT_NAME
        @chessclub   VARCHAR(100),
        @currentName VARCHAR(100),
        @newName     VARCHAR(100)
AS
    BEGIN
        DECLARE @orginTranCount INT
        SET @orginTranCount = @@TRANCOUNT
        IF @orginTranCount > 0
            SAVE TRANSACTION ProcedureSave
        ELSE
            BEGIN TRANSACTION
        BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM TOURNAMENT WHERE chessclubname = @chessclub AND tournamentname = @currentName)
            RAISERROR ('The given tournament does not exist', 16, 1)

        IF @newName IS NULL
            RAISERROR ('A tournament name cannot be NULL', 16, 1)

        IF EXISTS(SELECT 1 FROM TOURNAMENT WHERE chessclubname = @chessclub AND tournamentname = @newName)
            RAISERROR ('The new tournamentname is already in use', 16, 1)

        UPDATE TOURNAMENT SET tournamentname = @newName WHERE chessclubname = @chessclub AND tournamentname = @currentName

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