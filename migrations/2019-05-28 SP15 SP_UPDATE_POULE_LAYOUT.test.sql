-- +migrate Up
EXEC tSQLt.NewTestClass 'SP15';

-- +migrate Down
EXEC tSQLt.DropClass 'SP15';

-- +migrate Up
CREATE PROCEDURE SP15.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

    INSERT INTO TOURNAMENT_PLAYER_OF_POULE
        (
            pouleno,
            playerid,
            roundnumber,
            tournamentname,
            chessclubname
        )
    VALUES
        (
            2,
            200,
            20,
            'In het Gemaal',
            'Arnhemse schaakvereniging'
        ),
        (
            4,
            300,
            20,
            'In het Gemaal',
            'Arnhemse schaakvereniging'
        ),
        (
            3,
            400,
            20,
            'Onder het Gemaal',
            'Arnhemse schaakvereniging'
        )
END;

-- +migrate Up
CREATE PROCEDURE [SP15].[test_players_can_be_swapped]
AS 
BEGIN

    SELECT 
        pouleno,
        IIF(playerid = 200, 300, 200) playerid,
        roundnumber,
        tournamentname,
        chessclubname
    INTO #expected
    FROM TOURNAMENT_PLAYER_OF_POULE
    WHERE roundnumber = 20
        AND tournamentname = 'In het Gemaal'
        AND chessclubname = 'Arnhemse schaakvereniging'
        AND playerid in (200, 300)

	EXEC tSQLt.ExpectNoException

    EXEC SP_UPDATE_POULE_LAYOUT @chessclubname = 'Arnhemse schaakvereniging',
        @tournamentname = 'In het Gemaal',
        @roundnumber = 20,
        @playerA = 200,
        @playerB = 300

     SELECT 
        pouleno,
        playerid,
        roundnumber,
        tournamentname,
        chessclubname
    INTO #actual
    FROM TOURNAMENT_PLAYER_OF_POULE
    WHERE roundnumber = 20
        AND tournamentname = 'In het Gemaal'
        AND chessclubname = 'Arnhemse schaakvereniging'
        AND playerid in (200, 300)

    EXEC tSQLt.AssertEqualsTable #expected, #actual
END;

-- +migrate Up
CREATE PROCEDURE [SP15].[test_players_are_in_different_tournaments]
AS 
BEGIN
    EXEC tSQLt.ExpectException @ExpectedMessage = 'Could not find these players within this round.', @ExpectedSeverity = 16, @ExpectedErrorNumber = 50000

    EXEC SP_UPDATE_POULE_LAYOUT @chessclubname = 'Arnhemse schaakvereniging',
        @tournamentname = 'Onder het Gemaal',
        @roundnumber = 20,
        @playerA = 200,
        @playerB = 400
END;

-- +migrate Up
CREATE PROCEDURE [SP15].[test_tournament_does_not_exist]
AS 
BEGIN
    EXEC tSQLt.ExpectException @ExpectedMessage = 'The given tournament round cannot be found.', @ExpectedSeverity = 16, @ExpectedErrorNumber = 50000

    EXEC SP_UPDATE_POULE_LAYOUT @chessclubname = 'Arnhemse club',
        @tournamentname = 'Op het gemaal',
        @roundnumber = 20,
        @playerA = 200,
        @playerB = 400
END;
