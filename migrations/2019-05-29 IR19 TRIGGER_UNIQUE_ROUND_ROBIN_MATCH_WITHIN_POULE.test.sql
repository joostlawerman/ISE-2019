-- +migrate Down
EXEC tSQLt.DropClass 'IR19';

-- +migrate Up
EXEC tSQLt.NewTestClass 'IR19';

GO
CREATE PROCEDURE IR19.SetUp AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'

        INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber, system) VALUES
            ('test', 'round', 1, 'round robin'),
            ('test', 'brak', 1, 'bracket')

        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (1, 'test', 'round', 1, 1, 1, 2),
            (2, 'test', 'round', 1, 1, 3, 4),
            (3, 'test', 'brak', 1, 1, 3, 4)

        EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH_OF_POULE',
                                    @triggername = 'TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE'
    END;
GO

-- +migrate Up
CREATE PROCEDURE IR19.test_insert_duplicate_row AS
    BEGIN
        DELETE FROM CHESSMATCH_OF_POULE;

        EXEC tSQLt.ExpectException
            @ExpectedMessage = 'One of the matches that are inserted already exists in this round robin poule'
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (4, 'test', 'round', 1, 1, 1, 2)

    END;

GO

-- +migrate Up
CREATE PROCEDURE IR19.test_insert_duplicate_in_insert_statement AS
    BEGIN
        DELETE FROM CHESSMATCH_OF_POULE;

        EXEC tSQLt.ExpectException 'One of the matches that are inserted already exists in this round robin poule'
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (4, 'test', 'round', 1, 1, 1, 3),
            (5, 'test', 'round', 1, 1, 1, 3)
    END;
GO


-- +migrate Up
CREATE PROCEDURE IR19.test_single_insert_succeeds AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES (4, 'test', 'round', 1, 1, 1, 3)

    END;

GO

-- +migrate Up
CREATE PROCEDURE IR19.test_multi_insert_succeeds AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (4, 'test', 'round', 1, 1, 1, 3),
            (5, 'test', 'round', 1, 1, 2, 4)

    END;

GO
-- +migrate Up
CREATE PROCEDURE IR19.test_insert_duplicate_bracket AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (4, 'test', 'brak', 1, 1, 3, 4)
    END;

GO

-- +migrate Up
CREATE PROCEDURE IR19.test_insert_duplicate_bracket_in_insert AS
    BEGIN
        EXEC tSQLt.ExpectNoException
        -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (matchno, chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack)
        VALUES
            (4, 'test', 'brak', 1, 1, 3, 4),
            (5, 'test', 'brak', 1, 1, 3, 4)
    END;

go

EXEC tSQLt.Run 'IR19'