-- +migrate Down
EXEC tSQLt.DropClass 'SP27';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP27';

-- +migrate Up
CREATE PROCEDURE SP27.SetUp AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'

        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (1, 'Test', 'test', 1, 1, 1, 2),
            (1, 'Test', 'test', 1, 2, 1, 2),
            (1, 'Test', 'test', 1, 3, 1, 2),
            (1, 'Test', 'test', 4, 1, 1, 2)
    END;

-- +migrate Up
CREATE PROCEDURE SP27.test_select_matches_of_poule AS
    BEGIN
        SELECT *
        INTO expected
        FROM CHESSMATCH_OF_POULE
        WHERE roundnumber = 4


        EXEC tSQLt.ExpectNoException

        SELECT *
        INTO actual
        FROM CHESSMATCH_OF_POULE
        WHERE 1 = 0

        INSERT INTO actual EXEC SP_GET_MATCHES_OF_POULE 'Test', 'test', 4, 1

        EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
    END;

-- +migrate Up
CREATE PROCEDURE SP27.test_cannot_match_form_poule_without_chessclub AS
    BEGIN

        EXEC tSQLt.ExpectException 'There are no matches for this poule'

        INSERT INTO actual EXEC SP_GET_MATCHES_OF_POULE null, 'test', 4, 1
    END;

-- +migrate Up
CREATE PROCEDURE SP27.test_cannot_match_form_poule_without_tournament AS
    BEGIN

        EXEC tSQLt.ExpectException 'There are no matches for this poule'

        INSERT INTO actual EXEC SP_GET_MATCHES_OF_POULE 'Test', 4, 1
    END;

-- +migrate Up
CREATE PROCEDURE SP27.test_cannot_match_form_poule_without_roundnumber AS
    BEGIN

        EXEC tSQLt.ExpectException 'There are no matches for this poule'

        INSERT INTO actual EXEC SP_GET_MATCHES_OF_POULE 'Test', 'test', 5, 1
    END;

-- +migrate Up
CREATE PROCEDURE SP27.test_cannot_match_form_poule_with_incorrect_pouleno AS
    BEGIN

        EXEC tSQLt.ExpectException 'There are no matches for this poule'

        INSERT INTO actual EXEC SP_GET_MATCHES_OF_POULE 'Test', 'test', 4, 5
    END;
