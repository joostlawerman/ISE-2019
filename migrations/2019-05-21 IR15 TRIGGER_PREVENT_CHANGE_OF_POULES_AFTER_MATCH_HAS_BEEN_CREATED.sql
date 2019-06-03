-- +migrate Up
CREATE TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_INSERT
    ON TOURNAMENT_PLAYER_OF_POULE
    AFTER INSERT
AS
    IF @@ROWCOUNT = 0
        RETURN
SET NOCOUNT ON
BEGIN TRY

IF EXISTS(
    SELECT 1
    FROM inserted i
    INNER JOIN TOURNAMENT_PLAYER_OF_POULE t ON
        i.chessclubname = t.chessclubname AND
        i.tournamentname = t.tournamentname AND
        i.roundnumber = t.roundnumber
    WHERE EXISTS(
        SELECT 1
        FROM CHESSMATCH_OF_POULE P
        WHERE p.tournamentname = t.tournamentname AND
            p.chessclubname = t.chessclubname AND
            p.roundnumber = t.roundnumber
        )
    )
    BEGIN
        THROW 50000, 'A poule can not be changed when a match in that poule has started', 1
    END
END TRY
BEGIN CATCH
THROW
END CATCH;

-- +migrate Up
CREATE TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_UPDATE
    ON TOURNAMENT_PLAYER_OF_POULE
    AFTER UPDATE
AS
    IF @@ROWCOUNT = 0
        RETURN
SET NOCOUNT ON
BEGIN TRY

    IF NOT EXISTS(
        SELECT 1 
        FROM inserted i
        INNER JOIN deleted d ON 
            i.tournamentname = d.tournamentname AND
            i.chessclubname = d.chessclubname)
        BEGIN
    -- naam van toernooi of schaakclub veranderd. Toegestane wijziging aan een poule
            RETURN
        END

    IF EXISTS(
        SELECT 1
        FROM inserted i
        INNER JOIN TOURNAMENT_PLAYER_OF_POULE t ON
            i.chessclubname = t.chessclubname AND
            i.tournamentname = t.tournamentname AND
            i.roundnumber = t.roundnumber
        WHERE EXISTS(
            SELECT 1
            FROM CHESSMATCH_OF_POULE P
            WHERE p.tournamentname = t.tournamentname AND
                p.chessclubname = t.chessclubname AND
                p.roundnumber = t.roundnumber
            )
        )
    BEGIN
        THROW 50000, 'A poule can not be changed when a match in that poule has started', 1
    END
    
END TRY
BEGIN CATCH
THROW
END CATCH;

-- +migrate Down
DROP TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_INSERT;

-- +migrate Down
DROP TRIGGER TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_UPDATE;
