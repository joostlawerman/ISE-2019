-- +migrate Down
DROP PROCEDURE SP_ADD_PLAYER_TO_TOURNAMENT;

-- +migrate Up
CREATE PROCEDURE SP_ADD_PLAYER_TO_TOURNAMENT
        @chessclub  VARCHAR(100),
        @tournament VARCHAR(100),
        @player     INT
AS
    BEGIN
        DECLARE @orginTranCount INT
        SET @orginTranCount = @@TRANCOUNT
        IF @orginTranCount > 0
            SAVE TRANSACTION ProcedureSave
        ELSE
            BEGIN TRANSACTION
        BEGIN TRY
            IF (@chessclub IS NULL OR NOT EXISTS(SELECT 1
                                                 FROM CHESSCLUB
                                                 WHERE chessclubname = @chessclub))
                RAISERROR ('The given chessclubname does not exist', 16, 1)
            IF (@tournament IS NULL OR NOT EXISTS(SELECT 1
                                                  FROM TOURNAMENT
                                                  WHERE chessclubname = @chessclub
                                                        AND tournamentname = @tournament))
                RAISERROR ('The given tournamentname does not exist', 16, 1)
            IF (@player IS NULL OR NOT EXISTS(SELECT 1
                                              FROM PLAYER
                                              WHERE playerid = @player))
                RAISERROR ('The given playerid is unknown', 16, 1)


            INSERT INTO TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid) VALUES
                (@chessclub, @tournament, @player)

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

