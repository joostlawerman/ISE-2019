-- +migrate Down
DROP PROCEDURE SP_GET_MATCHES_OF_POULE;

-- +migrate Up
CREATE PROCEDURE SP_GET_MATCHES_OF_POULE
        @chessclubname  VARCHAR(100),
        @tournamentname VARCHAR(100),
        @roundnumber    INT,
        @pouleno        INT
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
                      FROM CHESSMATCH_OF_POULE
                      WHERE
                          chessclubname = @chessclubname AND
                          tournamentname = @tournamentname AND
                          roundnumber = @roundnumber AND
                          pouleno = @pouleno
        )
            BEGIN
                RAISERROR ('There are no matches for this poule', 16, 1)
            END

        SELECT *
        FROM CHESSMATCH_OF_POULE
        WHERE
            chessclubname = @chessclubname AND
            tournamentname = @tournamentname AND
            roundnumber = @roundnumber AND
            pouleno = @pouleno

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
