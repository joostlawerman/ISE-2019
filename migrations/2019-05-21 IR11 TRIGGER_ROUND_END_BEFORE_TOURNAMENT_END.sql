-- +migrate Down
DROP TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END;

-- +migrate Up
CREATE TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END
    ON TOURNAMENT_ROUND
    AFTER INSERT, UPDATE
AS
    BEGIN
        BEGIN
            IF @@ROWCOUNT = 0
                RETURN
            BEGIN TRY

            IF (exists(SELECT 1
                       FROM inserted i INNER JOIN TOURNAMENT t
                               ON t.chessclubname = i.chessclubname AND t.tournamentname = i.tournamentname
                       WHERE i.ends > t.ends AND i.ends IS NOT NULL AND t.ends IS NOT NULL))
                BEGIN
                    THROW 50001, 'A tournament round must end before the end of the tournament.', 1
                END
            END TRY
            BEGIN CATCH
            THROW
            END CATCH
        END
    END;