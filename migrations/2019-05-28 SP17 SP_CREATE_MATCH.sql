-- +migrate Down
DROP PROCEDURE SP_CREATE_MATCH;

-- +migrate Up
CREATE PROCEDURE SP_CREATE_MATCH
    @chessclubname  VARCHAR(100),
    @tournamentname VARCHAR(100),
    @roundnumber    INT,
    @poulno         INT,
    @whitePlayer    INT,
    @blackPlayer    INT
AS
    BEGIN
        DECLARE @orginTranCount INT
	SET  @orginTranCount = @@TRANCOUNT
	IF @orginTranCount > 0
        SAVE TRANSACTION ProcedureSave
    ELSE
        BEGIN TRANSACTION
	BEGIN TRY

        IF NOT EXISTS(
                SELECT 1
                FROM POULE
                WHERE chessclubname = @chessclubname
                  AND tournamentname = @tournamentname
                  AND roundnumber=@roundnumber
                  AND pouleno=@poulno)
            BEGIN
                RAISERROR('This poule does not exist', 16, 1)
            END

        IF NOT 2 = (
                SELECT count(*)
                FROM TOURNAMENT_PLAYER_OF_POULE
                WHERE chessclubname = @chessclubname
                  AND tournamentname = @tournamentname
                  AND roundnumber = @roundnumber
                  AND pouleno = @poulno
                  AND (playerid = @whitePlayer OR playerid = @blackPlayer)
        )
            BEGIN
                RAISERROR('The white or the black player does not compete in this poule', 16, 1)
            END

            DECLARE @matchno INT = (SELECT (SELECT TOP 1 matchno FROM CHESSMATCH_OF_POULE ORDER BY matchno DESC)+1)
            IF @matchno IS NULL
                BEGIN
                    SET @matchno = 1
                END

        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack, result) VALUES
            (@matchno, @chessclubname, @tournamentname, @roundnumber, @poulno, @whitePlayer, @blackPlayer, NULL)

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