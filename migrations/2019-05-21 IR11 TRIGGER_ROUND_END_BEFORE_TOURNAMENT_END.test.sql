-- +migrate Up
EXEC tSQLt.NewTestClass 'IR11';

-- +migrate Down
EXEC tSQLt.DropClass 'IR11';

-- +migrate Up
CREATE PROCEDURE [IR11].SetUp
AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
        EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                    @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'
        INSERT INTO TOURNAMENT (chessclubname, tournamentname, ends)
        VALUES
            ('test', 'test', '2019-10-10 10:00:00'),
            ('test', 'nulltest', NULL)

    END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_before_tournament_end]
AS
    BEGIN
        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, ends) VALUES
            ('test', 'test', '2008-11-11 13:23:44'),
            ('test', 'test', '2019-10-10 09:59:59')

    END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_on_tournament_end]
AS
    BEGIN
        EXEC tSQLt.ExpectException

        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, ends) VALUES
            ('test', 'test', '2019-11-11 10:00:00'),
            ('test', 'test', '2019-10-10 09:00:00')
    END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_after_tournament_end]
AS
    BEGIN
        EXEC tSQLt.ExpectException
        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, ends) VALUES
            ('test', 'test', '2019-11-11 10:00:00'),
            ('test', 'test', '2019-10-10 09:00:00')
    END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_tournament_end_is_null]
AS
    BEGIN
        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, ends) VALUES
            ('test', 'nulltest', '2012-05-21 10:20:00')
    END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_tournament_round_end_is_null]
AS
    BEGIN

        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, ends) VALUES
            ('test', 'test', NULL),
            ('test', 'test', '2019-10-10 09:00:00')
    END;

