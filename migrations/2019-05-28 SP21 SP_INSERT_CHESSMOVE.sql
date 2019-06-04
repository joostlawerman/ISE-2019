-- +migrate Down
DROP PROCEDURE SP_INSERT_CHESSMOVE;

-- +migrate Up
CREATE PROCEDURE SP_INSERT_CHESSMOVE
        @matchNo     INT,
        @moveNo      INT,
        @player      CHAR(1),
        @destination VARCHAR(6)
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
                RAISERROR ('There is no chessmatch with this number', 16, 1)
            END
        IF NOT @player IN ('B', 'W')
            BEGIN
                RAISERROR ('Player should be either "W" or "B"', 16, 1)
            END
        IF EXISTS(SELECT 1
                  FROM CHESSMATCHMOVE
                  WHERE matchno = @matchNo AND colour = @player AND moveno = @moveNo)
            BEGIN
                RAISERROR ('There is already a move recorded for this player with this movenumber', 16, 1)
            END
        IF LEN(@destination) < 2
            BEGIN
                RAISERROR ('This cannot be a valid move', 16, 1)
            END
        IF (LEN(@destination) = 2 AND NOT @destination LIKE '[a-h][1-8]')
           OR (LEN(@destination) = 3 AND NOT (@destination LIKE '[KQRBN][a-h][1-8]' OR @destination LIKE 'O-O' OR @destination LIKE '[a-h][1-8][#+]'))
           OR (LEN(@destination) = 4 AND
               NOT (@destination LIKE '[KQRBNa-h]x[a-h][1-8]' OR @destination LIKE '[a-h][1-8]=[QRBN]' OR @destination LIKE 'O-O[#+]' OR @destination LIKE '[QRBNa-h][a-h1-8][a-h][1-8]'))
           OR (LEN(@destination) = 5 AND
               NOT (@destination LIKE '[KQRBNa-h]x[a-h][1-8][#+]' OR @destination LIKE '[QRBNa-h][a-h1-8][a-h][1-8][#+]' OR @destination LIKE 'O-O-O' OR
                    @destination LIKE '[QRBNa-h][a-h1-8]x[a-h][1-8]' OR @destination LIKE '[a-h][1-8]=[QRBN][#+]' ))
           OR (LEN(@destination) = 6 AND NOT (@destination LIKE '[QRBNa-h][a-h1-8]x[a-h][1-8][#+]' OR @destination LIKE 'O-O-O[#+]'))
            BEGIN
                RAISERROR ('This is not a valid move', 16, 1)
            END
        INSERT INTO CHESSMATCHMOVE (matchno, moveno, colour, destination) VALUES
            (@matchNo, @moveNo, @player, @destination)

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
