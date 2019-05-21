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
				IF ((SELECT ends from inserted) is not null)
				BEGIN


					DECLARE @tournamentEnd datetime = (select t.ends
													   from TOURNAMENT t inner join inserted i 
														    on t.tournamentname = i.tournamentname 
														    and t.chessclubname = i.chessclubname)

					IF(@tournamentEnd is null)
					RETURN

					IF((select ends from inserted) > (@tournamentEnd))
						THROW 50001, 'A tournament round must end before the end of the tournament.',1

				END			
			END TRY
            BEGIN CATCH
				THROW
            END CATCH
        END
    END
;

-- +migrate Down
DROP TRIGGER TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END
;

