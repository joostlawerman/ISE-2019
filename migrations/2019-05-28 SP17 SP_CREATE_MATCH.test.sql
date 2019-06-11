-- +migrate Up
EXEC tSQLt.NewTestClass 'SP17';

-- +migrate Down
EXEC tSQLt.DropClass 'SP17';

-- +migrate Up
CREATE PROCEDURE SP17.SetUp
AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.POULE'
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER_OF_POULE'
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'

        INSERT INTO POULE(chessclubname, tournamentname, roundnumber, pouleno)
            VALUES
                ('Test', 'test', 1, 1)

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, playerid, tournamentname, roundnumber, pouleno)
            VALUES
                ('Test', 1, 'test', 1, 1),
                ('Test', 2, 'test', 1, 1)
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_missing_chessclubname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH NULL, 'test', 1, 1, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch__with_missing_tournamentname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', NULL, 1, 1, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_missing_roundnumber AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', 'test', NULL, 1,  1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_result_with_missing_pouleno AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', 'test', 1, NULL, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_missing_player AS
    BEGIN
        EXEC tSQLt.ExpectException 'The white or the black player does not compete in this poule'

        EXEC SP_CREATE_MATCH 'Test', 'test', 1, 1, null, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_non_competing_player AS
    BEGIN
        EXEC tSQLt.ExpectException 'The white or the black player does not compete in this poule'

        EXEC SP_CREATE_MATCH 'Test', 'test', 1, 1,  3, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_incorrect_poule AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', 'test', 1, 4, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_result_with_incorrect_roundnumber AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', 'test', 5, 1, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_incorrect_tournamentname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'Test', 'incorrect', 1, 1, 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_create_chessmatch_with_incorrect_chessclubname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_CREATE_MATCH 'incorrect', 'test', 1, 1, 1, 2
    END;