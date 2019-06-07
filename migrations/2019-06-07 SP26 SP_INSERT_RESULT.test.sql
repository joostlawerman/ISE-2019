-- +migrate Down
EXEC tSQLt.DropClass 'SP26';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP26';

-- +migrate Up
CREATE PROCEDURE SP26.SetUp AS
    BEGIN 
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'

        INSERT INTO CHESSMATCH_OF_POULE (matchno) VALUES (1), (2), (3)
    END;

-- +migrate Up
CREATE PROCEDURE SP26.test_can_insert_chessmatch_result_with_null_result AS
    BEGIN
        DELETE FROM CHESSMATCH_OF_POULE WHERE matchno > 1
        SELECT *
        INTO expected
        FROM CHESSMATCH_OF_POULE
        WHERE 1 = 0
        INSERT INTO expected (matchno, result)
        VALUES
            (1, NULL)

        EXEC tSQLt.ExpectNoException

        EXEC SP_INSERT_RESULT 1, NULL

        EXEC tSQLt.AssertEqualsTable 'expected', 'CHESSMATCH_OF_POULE'
    END;

-- +migrate Up
CREATE PROCEDURE SP26.test_cannot_insert_chessmatch_result_with_incorrect_result AS
    BEGIN

        EXEC tSQLt.ExpectException 'The result of a match must be one of "black", "white" or "remise"'

        EXEC SP_INSERT_RESULT 1, 'yellow'
    END;

-- +migrate Up
CREATE PROCEDURE SP26.test_can_insert_chessmatch_result AS
    BEGIN
        SELECT *
        INTO expected
        FROM CHESSMATCH_OF_POULE
        WHERE 1 = 0
        INSERT INTO expected (matchno, result)
        VALUES
            (1, 'black'),
            (2, 'white'),
            (3, 'remise')

        EXEC tSQLt.ExpectNoException

        EXEC SP_INSERT_RESULT 1, 'black'
        EXEC SP_INSERT_RESULT 2, 'white'
        EXEC SP_INSERT_RESULT 3, 'remise'

        EXEC tSQLt.AssertEqualsTable 'expected', 'CHESSMATCH_OF_POULE'
    END;
