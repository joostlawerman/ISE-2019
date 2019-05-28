-- +migrate Up
EXEC tSQLt.NewTestClass 'SP20';

-- +migrate Down
EXEC tSQLt.DropClass 'SP20';

-- +migrate Up
CREATE PROCEDURE SP20.SetUp
AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

        INSERT INTO TOURNAMENT(chessclubname, tournamentname)
            VALUES
                ('Test', 'testing')
    END;

-- +migrate Up
CREATE PROCEDURE SP20.test_successfully_change_tournament_name AS
    BEGIN
        SELECT * INTO expected FROM TOURNAMENT WHERE 1=0
        INSERT INTO expected (chessclubname, tournamentname)
        VALUES
            ('Test', 'tested')

        EXEC tSQLt.ExpectNoException

        EXEC SP_EDIT_TOURNAMENT_NAME 'Test', 'testing', 'tested'

        EXEC tSQLt.AssertEqualsTable 'expected', 'TOURNAMENT'

    END;


-- +migrate Up
CREATE PROCEDURE SP20.test_can_change_to_same_name_from_different_club AS
    BEGIN
        INSERT INTO TOURNAMENT(chessclubname, tournamentname)
            VALUES
                ('different club', 'tested')

        SELECT * INTO expected FROM TOURNAMENT WHERE 1=0
        INSERT INTO expected (chessclubname, tournamentname)
        VALUES
            ('Test', 'tested'),
            ('different club', 'tested')


        EXEC tSQLt.ExpectNoException

        EXEC SP_EDIT_TOURNAMENT_NAME 'Test', 'testing', 'tested'

        EXEC tSQLt.AssertEqualsTable 'expected', 'TOURNAMENT'
    END;


-- +migrate Up
CREATE PROCEDURE SP20.test_cannot_change_tournamentname_of_unknown_tournament AS
    BEGIN
        EXEC tSQLt.ExpectException 'The given tournament does not exist'

        EXEC SP_EDIT_TOURNAMENT_NAME 'Test', 'lols', 'tested'
    END;

-- +migrate Up
CREATE PROCEDURE SP20.test_new_tournamentname_cannot_be_null AS
    BEGIN
        EXEC tSQLt.ExpectException 'A tournament name cannot be NULL'

        EXEC SP_EDIT_TOURNAMENT_NAME 'Test', 'testing', null
    END;

-- +migrate Up
CREATE PROCEDURE SP20.test_new_tournamentname_already_in_use AS
    BEGIN
        INSERT INTO TOURNAMENT(chessclubname, tournamentname)
            VALUES ('Test', 'duplicate')

        EXEC tSQLt.ExpectException 'The new tournamentname is already in use'

        EXEC SP_EDIT_TOURNAMENT_NAME 'Test', 'testing', 'duplicate'
    END;
