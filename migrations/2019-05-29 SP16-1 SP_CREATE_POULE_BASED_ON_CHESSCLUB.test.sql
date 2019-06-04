-- +migrate Up
EXEC tSQLt.NewTestClass 'SP16_1';

-- +migrate Down
EXEC tSQLt.DropClass 'SP16_1';

-- +migrate Up
CREATE PROCEDURE SP16_1.SetUp
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

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND 
		VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 'round robin', null, null)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo', 'POULE'
END;


-- +migrate Up
CREATE PROCEDURE [SP16_1].[Test amout of players in a poule]
AS 
BEGIN
	--Act
	EXEC SP_CREATE_POULE_BASED_ON_CHESSCLUB 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1

	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 4) AS a)

	DECLARE @Actual2 int = (
		SELECT count(a.b) FROM(
		SELECT COUNT(*) as b FROM TOURNAMENT_PLAYER_OF_POULE GROUP BY pouleno HAVING COUNT(*) = 3) AS a)

	EXEC tSQLt.AssertEquals 2, @Actual1
	EXEC tSQLt.AssertEquals 2, @Actual2
END;

-- +migrate Up
ALTER PROCEDURE [SP16_1].[Test a poule is made based on chessclub]
AS 
BEGIN
	--Act
	EXEC SP_CREATE_POULE_BASED_ON_CHESSCLUB 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1
	--SELECT t.*, p.chessclubname FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid
	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
			SELECT p.chessclubname as b,  pouleno as c 
			FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid 
			GROUP BY p.chessclubname, pouleno 
			HAVING COUNT(p.chessclubname) < 3) AS a)

	SELECT @Actual1

	SELECT pouleno as c 
			FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid 
			GROUP BY pouleno
			HAVING COUNT(p.chessclubname) < 3

	--we moeten tellen hoevaak een chessclubname bij hetzelfde pouleno staat.

	EXEC tSQLt.AssertEquals 4, @Actual1
END;

-- +migrate Up
ALTER PROCEDURE [SP16_1].[Test too many players from the same chessclub]
AS 
BEGIN
	--Act
	EXEC SP_CREATE_POULE_BASED_ON_CHESSCLUB 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1
	--SELECT t.*, p.chessclubname FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid
	--Assert
	DECLARE @Actual1 int = (
		SELECT count(a.b) FROM(
			SELECT p.chessclubname as b 
			FROM TOURNAMENT_PLAYER_OF_POULE t INNER JOIN PLAYER p ON t.playerid = p.playerid 
			GROUP BY p.chessclubname 
			HAVING COUNT(p.chessclubname) > 2) AS a)
	--SELECT @Actual1

	EXEC tSQLt.AssertEquals null, @Actual1
END;

--EXEC tSQLt.run SP16_1