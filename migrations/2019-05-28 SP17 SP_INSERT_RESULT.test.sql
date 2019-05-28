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
CREATE PROCEDURE SP17.test_can_insert_chessmatch_result AS
    BEGIN
        SELECT * INTO expected FROM CHESSMATCH_OF_POULE WHERE 1=0
        INSERT INTO expected(matchno, chessclubname, tournamentname, roundnumber, pouleno, result, playeridwhite, playeridblack) VALUES
            (1, 'Test', 'test', 1,1, 'black', 1, 2),
            (2, 'Test', 'test', 1,1, 'white', 2, 1),
            (3, 'Test', 'test', 1,1, 'remise', 1, 2)

        EXEC tSQLt.ExpectNoException

        EXEC SP_INSERT_RESULT 'Test', 'test', 1,1, 'black', 1, 2
        EXEC SP_INSERT_RESULT 'Test', 'test', 1,1, 'white', 2, 1
        EXEC SP_INSERT_RESULT 'Test', 'test', 1,1, 'remise', 1, 2

        EXEC tSQLt.AssertEqualsTable 'expected', 'CHESSMATCH_OF_POULE'
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_null_result AS
    BEGIN
        SELECT * INTO expected FROM CHESSMATCH_OF_POULE WHERE 1=0
        INSERT INTO expected(matchno, chessclubname, tournamentname, roundnumber, pouleno, result, playeridwhite, playeridblack) VALUES
            (1, 'Test', 'test', 1,1, null, 1, 2)

        EXEC tSQLt.ExpectNoException

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, 1, null, 1, 2

        EXEC tSQLt.AssertEqualsTable 'expected', 'CHESSMATCH_OF_POULE'
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_missing_chessclubname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT NULL, 'test', 1, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_missing_tournamentname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', NULL, 1, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_missing_roundnumber AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', 'test', NULL, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_missing_pouleno AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, NULL, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_missing_player AS
    BEGIN
        EXEC tSQLt.ExpectException 'The white or the black player does not compete in this poule'

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, 1, 'black', null, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_non_competing_player AS
    BEGIN
        EXEC tSQLt.ExpectException 'The white or the black player does not compete in this poule'

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, 1, 'black', 3, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_incorrect_poule AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, 4, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_incorrect_roundnumber AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', 'test', 5, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_incorrect_tournamentname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'Test', 'incorrect', 1, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_incorrect_chessclubname AS
    BEGIN
        EXEC tSQLt.ExpectException 'This poule does not exist'

        EXEC SP_INSERT_RESULT 'incorrect', 'test', 1, 1, 'black', 1, 2
    END;

-- +migrate Up
CREATE PROCEDURE SP17.test_cannot_insert_chessmatch_result_with_incorrect_result AS
    BEGIN
        EXEC tSQLt.ExpectException 'The result of a match must be one of "black", "white" or "remise"'

        EXEC SP_INSERT_RESULT 'Test', 'test', 1, 1, 'yellow', 1, 2
    END;
