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

-- +migrate Up 
CREATE TRIGGER TRIGGER_PLAYER_TOURNAMENT_OF_POULE_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE
    ON TOURNAMENT_PLAYER_OF_POULE
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        
        SET NOCOUNT ON

        BEGIN TRY
            IF EXISTS(
                SELECT 1
                FROM Inserted i
                WHERE EXISTS (
                    SELECT 1
                    FROM CHESSMATCH cm
                    WHERE cm.chessclubname = i.chessclubname
                        AND cm.tournamentname = i.tournamentname
                        AND cm.roundnumber = i.roundnumber
                        AND cm.pouleno <> i.pouleno
                        AND (
                            cm.playeridwhite = i.playerid
                            OR cm.playeridblack = i.playerid
                        )
                )
            )
                BEGIN
                    THROW 50005, 'You cannnot change the poule of a player when the player is already in a match within it''s current poule.', 1
                END
        END TRY
        BEGIN CATCH
            THROW
        END CATCH
    END
;

-- +migrate Down
DROP TRIGGER TRIGGER_PLAYER_TOURNAMENT_OF_POULE_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE
;

