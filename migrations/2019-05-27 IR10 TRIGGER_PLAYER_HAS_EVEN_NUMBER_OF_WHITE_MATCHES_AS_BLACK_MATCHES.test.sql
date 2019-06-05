-- +migrate Up
EXEC tSQLt.NewTestClass 'ir10';

-- +migrate Down
EXEC tSQLt.DropClass 'ir10';

-- +migrate Up
CREATE PROCEDURE ir10.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH_OF_POULE'

    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH_OF_POULE', @triggername = 'TRIGGER_PLAYER_HAS_EVEN_NUMBER_OF_WHITE_MATCHES_AS_BLACK_MATCHES'

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 200, 100)

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 100, 400)

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 400, 100)
END;

-- +migrate Up
CREATE PROCEDURE [ir10].[test_player_has_previous_matches]
AS 
BEGIN
    EXEC tSQLt.ExpectNoException

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 400, 600)
END;

-- +migrate Up
CREATE PROCEDURE [ir10].[test_player_has_no_previous_matches]
AS 
BEGIN
    EXEC tSQLt.ExpectNoException

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 900, 800)
END;

-- +migrate Up
CREATE PROCEDURE [ir10].[test_player_has_to_many_black_matches]
AS 
BEGIN
    EXEC tSQLt.ExpectException @ExpectedMessage = 'One of the players has been added too many black or white matches within a poule.', 
        @ExpectedSeverity = 16, 
        @ExpectedErrorNumber = 50000

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 200, 600)
END;

-- +migrate Up
CREATE PROCEDURE [ir10].[test_player_has_to_many_white_matches]
AS 
BEGIN
    EXEC tSQLt.ExpectException @ExpectedMessage = 'One of the players has been added too many black or white matches within a poule.', 
        @ExpectedSeverity = 16, 
        @ExpectedErrorNumber = 50000

    INSERT INTO CHESSMATCH_OF_POULE
        (chessclubname, tournamentname, roundnumber, pouleno, playeridblack, playeridwhite)
    VALUES
        ('Arnhemse Schaakers', 'In het Gemaal', 20, 10, 600, 100)
END;
