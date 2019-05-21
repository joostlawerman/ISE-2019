-- +migrate Up 
CREATE TRIGGER TRIGGER_CHESSMATCH_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE
    ON CHESSMATCH
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        
        SET NOCOUNT ON

        BEGIN TRY
            IF NOT EXISTS(
                SELECT 1
                FROM TOURNAMENT_PLAYER_OF_POULE tp_of_p
                WHERE EXISTS (
                    SELECT 1
                    FROM Inserted i
                    WHERE i.chessclubname = tp_of_p.chessclubname
                        AND i.tournamentname = tp_of_p.tournamentname
                        AND i.roundnumber = tp_of_p.roundnumber
                        AND i.pouleno = tp_of_p.pouleno
                        AND (
                            i.playeridwhite = tp_of_p.playerid
                            OR i.playeridblack = tp_of_p.playerid
                        )
                )
                GROUP BY tp_of_p.chessclubname,
                    tp_of_p.tournamentname,
                    tp_of_p.roundnumber,
                    tp_of_p.pouleno
                HAVING COUNT(*) = 2
            )
                BEGIN
                    THROW 50005, 'Player should be in the poule of the chess match.', 1
                END
        END TRY
        BEGIN CATCH
            THROW
        END CATCH
    END
;

-- +migrate Down
DROP TRIGGER TRIGGER_CHESSMATCH_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE
;
