-- +migrate Up
EXEC tSQLt.NewTestClass 'SP25';

-- +migrate Down
EXEC tSQLt.DropClass 'SP25';

-- +migrate Up
CREATE PROCEDURE SP25.SetUp AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo.POULE'
    EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER_OF_POULE'

    INSERT INTO POULE VALUES
        ('test', 'test', 1, 1),
        ('test', 'test', 1, 2)

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno, playerid) VALUES
        ('test', 'test', 1, 1, 1),
        ('test', 'test', 1, 1, 2),
        ('test', 'test', 1, 1, 3),
        ('test', 'test', 1, 1, 4)
END;

-- +migrate Up
CREATE PROCEDURE SP25.test_get_all_players AS
BEGIN
    SELECT playerid INTO expected FROM TOURNAMENT_PLAYER_OF_POULE

    exec tSQLt.ExpectNoException

    SELECT playerid INTO actual FROM TOURNAMENT_PLAYER_OF_POULE WHERE 1=0

    INSERT INTO actual EXEC SP_GET_PLAYERS_OF_POULE 'test', 'test', 1, 1

    EXEC tSQLt.AssertEqualsTable expected, actual
END;

-- +migrate Up
CREATE PROCEDURE SP25.test_poule_does_not_exist AS
BEGIN

    exec tSQLt.ExpectException 'This poule does not exist'

    EXEC SP_GET_PLAYERS_OF_POULE 'does', 'not', 3, 2
END;