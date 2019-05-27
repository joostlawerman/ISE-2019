-- +migrate Up
EXEC tSQLt.NewTestClass 'SP6';

-- +migrate Down
EXEC tSQLt.DropClass 'SP6';

-- +migrate Up
CREATE PROCEDURE SP6.SetUp AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER'

        INSERT INTO PLAYER (playerid) VALUES (1)
        INSERT INTO CHESSCLUB (chessclubname) VALUES ('test')
        INSERT INTO TOURNAMENT (chessclubname, tournamentname) VALUES ('test', 'testen')

    END;

-- +migrate Up
CREATE PROCEDURE SP6.test_successfully_add_player AS
BEGIN
    SELECT *
        INTO expected FROM TOURNAMENT_PLAYER WHERE 1=0
    INSERT INTO expected(chessclubname, tournamentname, playerid, paid) VALUES ('test', 'testen', 1,0)

    EXEC tSQLt.ExpectNoException
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', 1, 0

    EXEC tSQLt.AssertEqualsTable 'expected', TOURNAMENT_PLAYER

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_unknown_chessclub AS
BEGIN

    EXEC tSQLt.ExpectException 'The given chessclubname does not exist'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'Tilburg', 'testen', 1, 0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_null_chessclub AS
BEGIN

    EXEC tSQLt.ExpectException 'The given chessclubname does not exist'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT null, 'testen', 1, 0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_unknown_tournament AS
BEGIN

    EXEC tSQLt.ExpectException 'The given tournamentname does not exist'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'tester', 1, 0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_null_tournament AS
BEGIN

    EXEC tSQLt.ExpectException 'The given tournamentname does not exist'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', null, 1,0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_unknown_player AS
BEGIN

    EXEC tSQLt.ExpectException 'The given playerid is unknown'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', 2, 0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_fails_because_null_player AS
BEGIN

    EXEC tSQLt.ExpectException 'The given playerid is unknown'
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', null, 0

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_paid_is_false AS
BEGIN

    SELECT *
        INTO expected FROM TOURNAMENT_PLAYER WHERE 1=0
    INSERT INTO expected(chessclubname, tournamentname, playerid, paid) VALUES ('test', 'testen', 1,0)

    EXEC tSQLt.ExpectNoException
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', 1, 0

    EXEC tSQLt.AssertEqualsTable 'expected', TOURNAMENT_PLAYER

END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_paid_is_true AS
BEGIN

    SELECT *
        INTO expected FROM TOURNAMENT_PLAYER WHERE 1=0
    INSERT INTO expected(chessclubname, tournamentname, playerid, paid) VALUES ('test', 'testen', 1, 1)

    EXEC tSQLt.ExpectNoException
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', 1, 1

    EXEC tSQLt.AssertEqualsTable 'expected', TOURNAMENT_PLAYER
END;

-- +migrate Up
CREATE PROCEDURE SP6.test_add_player_paid_gets_set_to_false_when_unknown AS
BEGIN

    SELECT *
        INTO expected FROM TOURNAMENT_PLAYER WHERE 1=0
    INSERT INTO expected(chessclubname, tournamentname, playerid, paid) VALUES ('test', 'testen', 1, 0)

    EXEC tSQLt.ExpectNoException
    -- Execute
    EXEC SP_ADD_PLAYER_TO_TOURNAMENT 'test', 'testen', 1, null

    EXEC tSQLt.AssertEqualsTable 'expected', TOURNAMENT_PLAYER
END;