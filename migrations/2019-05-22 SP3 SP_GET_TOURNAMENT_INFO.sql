-- +migrate Up
CREATE PROCEDURE SP_GET_TOURNAMENT_INFO
    @chessclubname VARCHAR(100),
    @tournamentname varchar(100)

    AS
    BEGIN
        DECLARE @orginTranCount INT
        SET @orginTranCount = @@TRANCOUNT
        IF @orginTranCount > 0
            SAVE TRANSACTION ProcedureSave
        ELSE
            BEGIN TRANSACTION
        BEGIN TRY
        IF NOT EXISTS(SELECT 1
                      FROM CHESSCLUB
                      WHERE chessclubname = @chessclubname)
            BEGIN
                RAISERROR ('There is no chessclub with this name', 16, 1)
            END
        ELSE IF NOT EXISTS(SELECT 1
                           FROM TOURNAMENT
                           WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname)
            BEGIN
                RAISERROR ('There is no tournament with this name', 16, 1)
            END
        SELECT *
        FROM TOURNAMENT
        WHERE tournamentname = @tournamentname AND chessclubname = @chessclubname
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

-- +migrate Down
DROP PROCEDURE SP_GET_TOURNAMENT_INFO;