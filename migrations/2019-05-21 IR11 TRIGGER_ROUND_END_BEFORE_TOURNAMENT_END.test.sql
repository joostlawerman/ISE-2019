-- +migrate Up
EXEC tSQLt.NewTestClass 'IR11';

-- +migrate Down
EXEC tSQLt.DropClass 'IR11';

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_before_tournament_end]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    INSERT INTO
        TOURNAMENT (chessclubname, tournamentname, winner, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:00:00', NULL, NULL, NULL, NULL, NULL)

    EXEC tSQLt.ExpectNoException

    INSERT INTO
        TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2008-11-11 13:23:44')
END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_on_tournament_end]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    INSERT INTO
        TOURNAMENT (chessclubname, tournamentname, winner, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:00:00', NULL, NULL, NULL, NULL, NULL)

    EXEC tSQLt.ExpectNoException

    INSERT INTO
        TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:00:00')
END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_after_tournament_end]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    INSERT INTO
        TOURNAMENT (chessclubname, tournamentname, winner, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:00:00', NULL, NULL, NULL, NULL, NULL)

    EXEC tSQLt.ExpectException

    INSERT INTO
        TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:20:00')
END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_tournament_end_is_null]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    INSERT INTO
        TOURNAMENT (chessclubname, tournamentname, winner, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
    VALUES ('test', 'testen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

    EXEC tSQLt.ExpectNoException

    INSERT INTO
        TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2012-05-21 10:20:00')
END;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_tournament_round_end_is_null]
AS
BEGIN
    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND',
                                @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

    EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    INSERT INTO
        TOURNAMENT (chessclubname, tournamentname, winner, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
    VALUES ('test', 'testen', NULL, NULL, NULL, '2019-05-21 10:00:00', NULL, NULL, NULL, NULL, NULL)

    EXEC tSQLt.ExpectNoException

    INSERT INTO
        TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system, starts, ends)
    VALUES ('test', 'testen', NULL, NULL, NULL, NULL)
END;

