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
    ), (
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
    ), (
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
