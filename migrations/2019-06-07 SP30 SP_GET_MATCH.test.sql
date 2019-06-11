-- +migrate Down
EXEC tSQLt.DropClass 'SP30';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP30';

-- +migrate Up
CREATE PROCEDURE SP30.SetUp AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'

        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (1, 'Test', 'test', 1, 1, 1, 2)
    END;

-- +migrate Up
CREATE PROCEDURE SP30.test_select_match AS
    BEGIN
        SELECT *
        INTO expected
        FROM CHESSMATCH_OF_POULE

        EXEC tSQLt.ExpectNoException

        SELECT *
        INTO actual
        FROM CHESSMATCH_OF_POULE
        WHERE 1 = 0

        INSERT INTO actual EXEC SP_GET_MATCH 1

        EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
    END;