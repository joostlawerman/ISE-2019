-- +migrate Up
EXEC tSQLt.NewTestClass 'SP16_5';

-- +migrate Down
EXEC tSQLt.DropClass 'SP16_5';


-- +migrate Up
CREATE PROCEDURE SP16_5.SetUp
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
			(14, 'Schaakvereniging Almere', null, null, null, null, null, null, null, null),
			(15, 'Schaakvereniging Almere', null, null, null, null, null, null, null, null)

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
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 14, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 15, null)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo', 'POULE'

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND' 
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 'round robin', null, null)

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
			(13, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 9, 12, 'remise'),
			(14, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 10, 11, 'black'),
			(15, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 11, 9, 'black'),
			(15, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 12, 10, 'black'),
			(15, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 9, 10, 'black'),
			(15, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 11, 12, 'black'),
			(16, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 13, 15, 'white'),
			(17, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 15, 14, 'black'),
			(18, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 4, 14, 13, 'black')
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test amout of players in a first poule]
AS 
BEGIN
	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 0

	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 4) AS a)
	
	DECLARE @Actual2 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 3) AS a)

	EXEC tSQLt.AssertEquals 3, @Actual1
	EXEC tSQLt.AssertEquals 1, @Actual2
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test amout of players in a normal poule]
AS 
BEGIN
	--Arrange
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 'round robin', null, null)

	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 0

	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 4) AS a)
	
	DECLARE @Actual2 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 3) AS a)

	EXEC tSQLt.AssertEquals 3, @Actual1
	EXEC tSQLt.AssertEquals 1, @Actual2
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test amout of players in a finale poule]
AS 
BEGIN
	--Arrange
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 'round robin', null, null)

	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 1

	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 8) AS a)
	
	DECLARE @Actual2 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 7) AS a)

	EXEC tSQLt.AssertEquals 1, @Actual1
	EXEC tSQLt.AssertEquals 1, @Actual2
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test a first poule is made based on chessclub]
AS 
BEGIN
	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 0
	DECLARE @Actual1 int = (SELECT 1 FROM (
											SELECT t.pouleno, p.chessclubname, COUNT(*) AS cnt
											FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid
											GROUP BY t.pouleno, p.chessclubname) AS a
							WHERE a.cnt > 2)

	--Assert
	EXEC tSQLt.AssertEquals null, @Actual1
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test a normal poule is made based on score]
AS 
BEGIN
	--Arrange
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 'round robin', null, null)

	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 0

	SELECT tp.playerid
	INTO #TEMP_PLAYERS_IN_ROUND
	FROM TOURNAMENT_PLAYER tp INNER JOIN PLAYER p ON tp.playerid = p.playerid 
	WHERE tp.chessclubname = 'Schaakvereniging Horst' AND tp.tournamentname = 'Eerste schaaktoernooi'
		
	CREATE TABLE #TEMP_PLAYER_SCORE_IN_ROUND(
		playerid int,
		score decimal(5,2) 
	)

	DECLARE @currentPlayer int

	WHILE ((SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) != 0)
	BEGIN
		SET @currentPlayer = (SELECT TOP 1 playerid FROM #TEMP_PLAYERS_IN_ROUND)
		INSERT INTO #TEMP_PLAYER_SCORE_IN_ROUND EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, @currentPlayer
		DELETE FROM #TEMP_PLAYERS_IN_ROUND WHERE playerid = @currentPlayer
	END

	DECLARE @actual1 int = (SELECT pouleno FROM TOURNAMENT_PLAYER_OF_POULE WHERE playerid = (SELECT TOP 1 playerid FROM #TEMP_PLAYER_SCORE_IN_ROUND ORDER BY score DESC) AND roundnumber = 2)
	DECLARE @actual2 int = (SELECT pouleno FROM TOURNAMENT_PLAYER_OF_POULE WHERE playerid = (SELECT TOP 1 playerid FROM #TEMP_PLAYER_SCORE_IN_ROUND ORDER BY score ASC) AND roundnumber = 2)

	DECLARE @expected int = (SELECT TOP 1 pouleno FROM TOURNAMENT_PLAYER_OF_POULE ORDER BY pouleno DESC)

	--Assert
	EXEC tSQLt.AssertEquals 1, @Actual1
	EXEC tSQLt.AssertEquals @expected, @Actual2
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test a finale poule is made based on score]
AS 
BEGIN
	--Arrange
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 'round robin', null, null)

	--Act
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 1

	SELECT tp.playerid
	INTO #TEMP_PLAYERS_IN_ROUND
	FROM TOURNAMENT_PLAYER tp INNER JOIN PLAYER p ON tp.playerid = p.playerid 
	WHERE tp.chessclubname = 'Schaakvereniging Horst' AND tp.tournamentname = 'Eerste schaaktoernooi'
		
	CREATE TABLE #TEMP_PLAYER_SCORE_IN_ROUND(
		playerid int,
		score decimal(5,2) 
	)

	DECLARE @currentPlayer int

	WHILE ((SELECT COUNT(*) FROM #TEMP_PLAYERS_IN_ROUND) != 0)
	BEGIN
		SET @currentPlayer = (SELECT TOP 1 playerid FROM #TEMP_PLAYERS_IN_ROUND)
		INSERT INTO #TEMP_PLAYER_SCORE_IN_ROUND EXEC SP_GET_POINTS_OF_PLAYER_FROM_ROUND 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, @currentPlayer
		DELETE FROM #TEMP_PLAYERS_IN_ROUND WHERE playerid = @currentPlayer
	END

	DECLARE @actual1 int = (SELECT pouleno FROM TOURNAMENT_PLAYER_OF_POULE WHERE playerid = (SELECT TOP 1 playerid FROM #TEMP_PLAYER_SCORE_IN_ROUND ORDER BY score DESC) AND roundnumber = 2)
	DECLARE @actual2 int = (SELECT pouleno FROM TOURNAMENT_PLAYER_OF_POULE WHERE playerid = (SELECT TOP 1 playerid FROM #TEMP_PLAYER_SCORE_IN_ROUND ORDER BY score ASC) AND roundnumber = 2)

	DECLARE @expected int = (SELECT TOP 1 pouleno FROM TOURNAMENT_PLAYER_OF_POULE ORDER BY pouleno DESC)

	--Assert
	EXEC tSQLt.AssertEquals 1, @Actual1
	EXEC tSQLt.AssertEquals @expected, @Actual2
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test there is no round with this roundnumber in this tournament]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no round with this number in this tournament'

	--Assert
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 0
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test if a chessclub does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	--Assert
	EXEC SP_CREATE_POULES 'Schaakvereniging Flevoland', 'Eerste schaaktoernooi', 1, 0
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test if a tournament name does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	--Assert
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Tweede schaaktoernooi', 1, 0
END;


-- +migrate Up
CREATE PROCEDURE [SP16_5].[Test if a round has a round robin system]
AS 
BEGIN
	--Arange
	INSERT INTO TOURNAMENT_ROUND
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 'brack', null, null)

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'The system currently only supports round robin'

	--Assert
	EXEC SP_CREATE_POULES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 0
END;