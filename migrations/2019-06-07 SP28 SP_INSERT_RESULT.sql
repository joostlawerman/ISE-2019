-- +migrate Down
DROP PROCEDURE SP_INSERT_RESULT;

-- +migrate Up
CREATE PROCEDURE SP_INSERT_RESULT
    @matchNo INT,
    @result char(6)
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
                      WHERE matchno = @matchNo)
            BEGIN
                RAISERROR ('This match does not exist', 16, 1)
            END

        IF @result IS NOT NULL AND @result NOT IN ('black', 'white', 'remise')
            BEGIN
                RAISERROR ('The result of a match must be one of "black", "white" or "remise"', 16, 1)
            END

        UPDATE CHESSMATCH_OF_POULE SET result = @result WHERE matchno = @matchNo

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
