-- +migrate Up
EXEC tSQLt.NewTestClass 'ir20';

-- +migrate Down
EXEC tSQLt.DropClass 'ir20';

-- +migrate Up
CREATE PROCEDURE [ir20].[test_player_of_chess_match_is_in_poule]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH', @triggername = 'TRIGGER_CHESSMATCH_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE'

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300
    )

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 200
    )

    EXEC tSQLt.ExpectNoException
    
    INSERT INTO CHESSMATCH (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playeridwhite,
        playeridblack
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300, 200
    )
END
;

-- +migrate Up
CREATE PROCEDURE [ir20].[test_player_of_chess_match_is_not_in_poule]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH', @triggername = 'TRIGGER_CHESSMATCH_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE'

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300
    )

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 8, 200
    )

    EXEC tSQLt.ExpectException @ExpectedMessage = 'Player should be in the poule of the chess match.', @ExpectedSeverity = 16, @ExpectedErrorNumber = 50005
    
    INSERT INTO CHESSMATCH (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playeridwhite,
        playeridblack
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300, 200
    )
END
;

-- +migrate Up
CREATE PROCEDURE [ir20].[test_player_is_within_chessmatch]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_PLAYER_OF_POULE', @triggername = 'TRIGGER_PLAYER_TOURNAMENT_OF_POULE_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE'

    INSERT INTO CHESSMATCH (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playeridwhite,
        playeridblack
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300, 200
    )

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300
    )

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 200
    )


    
    EXEC tSQLt.ExpectException @ExpectedMessage = 'You cannnot change the poule of a player when the player is already in a match within it''s current poule.', @ExpectedSeverity = 16, @ExpectedErrorNumber = 50005

    UPDATE TOURNAMENT_PLAYER_OF_POULE
        SET pouleno = 8
    WHERE chessclubname = 'Arnhemse Schaak Club'
        AND tournamentname = 'In het Gemaal'
        AND roundnumber =  1
        AND playerid = 200
END
;



-- +migrate Up
CREATE PROCEDURE [ir20].[test_player_has_no_chessmatch]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_PLAYER_OF_POULE', @triggername = 'TRIGGER_PLAYER_TOURNAMENT_OF_POULE_PLAYERS_FROM_MATCH_SHOULD_BE_IN_POULE'

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 300
    )

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE (
        chessclubname, 
        tournamentname,
        roundnumber,
        pouleno,
        playerid
    ) VALUES (
        'Arnhemse Schaak Club', 'In het Gemaal', 1, 10, 200
    )

    EXEC tSQLt.ExpectNoException

    UPDATE TOURNAMENT_PLAYER_OF_POULE
        SET pouleno = 8
    WHERE chessclubname = 'Arnhemse Schaak Club'
        AND tournamentname = 'In het Gemaal'
        AND roundnumber =  1
        AND playerid = 200
END
;

