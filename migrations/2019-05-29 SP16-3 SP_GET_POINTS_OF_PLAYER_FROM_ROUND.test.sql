-- +migrate Up
EXEC tSQLt.NewTestClass 'SP16_3';

-- +migrate Down
EXEC tSQLt.DropClass 'SP16_3';

-- +migrate Up
CREATE PROCEDURE SP16_3.SetUp
AS
BEGIN
   	--Arrange
		EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB 
	VALUES	('Schaakvereniging Horst', null, null, null, null),	
			('Schaakvereniging Deventer', null, null, null, null),
			('Schaakvereniging Apeldoorn', null, null, null, null),
			('Schaakvereniging Arnhem', null, null, null, null),
			('Schaakvereniging Groningen', null, null, null, null),
			('Schaakvereniging Almere', null, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	INSERT INTO PLAYER 
	VALUES	(1, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
			(2, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
			(3, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
			(4, 'Schaakvereniging Deventer', null, null, null, null, null, null, null, null),
			(5, 'Schaakvereniging Deventer', null, null, null, null, null, null, null, null),
			(6, 'Schaakvereniging Apeldoorn', null, null, null, null, null, null, null, null),
			(7, 'Schaakvereniging Apeldoorn', null, null, null, null, null, null, null, null),
			(8, 'Schaakvereniging Arnhem', null, null, null, null, null, null, null, null),
			(9, 'Schaakvereniging Arnhem', null, null, null, null, null, null, null, null),
			(10, 'Schaakvereniging Arnhem', null, null, null, null, null, null, null, null),
			(11, 'Schaakvereniging Groningen', null, null, null, null, null, null, null, null),
			(12, 'Schaakvereniging Groningen', null, null, null, null, null, null, null, null),
			(13, 'Schaakvereniging Almere', null, null, null, null, null, null, null, null),
			(14, 'Schaakvereniging Almere', null, null, null, null, null, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', null, null, null, null, null, null, null, null, null)	
	
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER'
	INSERT INTO TOURNAMENT_PLAYER
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 3, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 4, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 5, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 6, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 7, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 8, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 9, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 10, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 11, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 12, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 13, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 14, null)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, null, null, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'POULE'

	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH_OF_POULE' 
	INSERT INTO CHESSMATCH_OF_POULE
	VALUES	(1, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 1, 4, 'black'),
			(2, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 2, 3, 'white'),
			(3, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 3, 1, 'remise'),
			(4, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 4, 2, 'black'),
			(5, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 1, 2, 'remise'),
			(6, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 3, 4, 'black'),
			(7, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 5, 8, 'black'),
			(8, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 6, 7, 'white'),
			(9, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 7, 5, 'remise'),
			(10, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 8, 6, 'black'),
			(11, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 5, 6, 'black'),
			(12, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 2, 7, 8, 'white'),
			(13, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 9, 11, 'remise'),
			(14, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 11, 10, 'black'),
			(15, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 10, 9, 'black'),
			(16, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 12, 14, 'white'),
			(17, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 14, 13, 'remise'),
			(18, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 13, 12, 'black')
END;

-- +migrate Up
CREATE PROCEDURE [SP16_3].[Test if player score is correct]
AS 
BEGIN
	--Act
	CREATE TABLE #TEMP(
		playerid int,
		score decimal(5,2) 
	)

	INSERT #TEMP EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 1

	DECLARE @actual DECIMAL
	SET @actual = (SELECT TOP 1 score FROM #TEMP)

	--Assert
	EXEC tSQLt.AssertEquals 1, @actual
END;

-- +migrate Up
CREATE PROCEDURE [SP16_3].[Test chessclub doesnt exist]
AS 
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'niet bestaande Schaakvereniging', 'Eerste schaaktoernooi', 2, 1
END;

-- +migrate Up
CREATE PROCEDURE [SP16_3].[Test tourny doesnt exist]
AS 
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'niet bestaande schaaktoernooi', 2, 1
END;

-- +migrate Up
CREATE PROCEDURE [SP16_3].[Test player doesnt exist]
AS 
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no player with this playerid in this round'

	EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 38
END;

-- +migrate Up
CREATE PROCEDURE [SP16_3].[Test round doesnt exist]
AS 
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no round with this roundnumber in this tournament'

	EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 99, 1
END;