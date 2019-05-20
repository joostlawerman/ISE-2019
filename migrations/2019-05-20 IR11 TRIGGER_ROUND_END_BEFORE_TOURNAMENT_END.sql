-- +migrate Up
create TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END
    ON TOURNAMENT_ROUND
    AFTER INSERT, UPDATE
    AS
    BEGIN
        BEGIN
          IF @@ROWCOUNT = 0
        RETURN
            BEGIN TRY
				IF UPDATE (ends) OR EXISTS (SELECT * FROM inserted)
				DECLARE @tournamentEnd VARCHAR(255) = (SELECT ends FROM TOURNAMENT where tournamentname = (Select tournamentname from inserted) and chessclubname = (Select chessclubname from inserted))
				END TRY
            BEGIN CATCH
			;THROW
            END CATCH
        END
    END
;

-- +migrate Down
DROP TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END
;