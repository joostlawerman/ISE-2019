-- +migrate Up
EXEC tSQLt.NewTestClass 'SP13';

-- +migrate Down
EXEC tSQLt.DropClass 'SP13';

-- +migrate Up
CREATE PROCEDURE [SP13].[Test get all poules of a round]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')	
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname, chessclubname) VALUES ('tourny1', 'cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber) VALUES ('cc1', 'tourny1', 1)
	EXEC tSQLt.FakeTable 'dbo', 'POULE'		
	INSERT INTO POULE 
	VALUES	('cc1', 'tourny1', 1, 1),
			('cc1', 'tourny1', 1, 2),
			('cc1', 'tourny1', 1, 3),
			('cc1', 'tourny1', 2, 1),
			('cc1', 'tourny1', 2, 2)

	CREATE TABLE exptected (
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		roundnumber    INT          NOT NULL,
		pouleno        INT          NOT NULL
	)

	INSERT INTO expected 
	VALUES	('cc1', 'tourny1', 1, 1),
			('cc1', 'tourny1', 1, 2),
			('cc1', 'tourny1', 1, 3)

	--Act
	CREATE TABLE actual (
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		roundnumber    INT          NOT NULL,
		pouleno        INT          NOT NULL
	)
	
	INSERT INTO actual SP_GET_POULES_OF_ROUND 'cc1', 'tourny1', 1
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'

END;

-- +migrate Up
CREATE PROCEDURE [SP13].[Test chessclub unkown]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')	
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname, chessclubname) VALUES ('tourny1', 'cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber) VALUES ('cc1', 'tourny1', 1)
	EXEC tSQLt.FakeTable 'dbo', 'POULE'	
	INSERT INTO POULE 
	VALUES	('cc1', 'tourny1', 1, 1),
			('cc1', 'tourny1', 1, 2),
			('cc1', 'tourny1', 1, 3)   

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'
	
	EXEC SP_GET_POULES_OF_ROUND 'blabla', 'tourny1', 1
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'POULE', 'actual'

END;

-- +migrate Up
CREATE PROCEDURE [SP13].[Test tourny unkown]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')	
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname, chessclubname) VALUES ('tourny1', 'cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber) VALUES ('cc1', 'tourny1', 1)
	EXEC tSQLt.FakeTable 'dbo', 'POULE'	
	INSERT INTO POULE 
	VALUES	('cc1', 'tourny1', 1, 1),
			('cc1', 'tourny1', 1, 2),
			('cc1', 'tourny1', 1, 3)   

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'
	
	EXEC SP_GET_POULES_OF_ROUND 'cc1', 'blabla', 1
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'POULE', 'actual'

END;

-- +migrate Up
CREATE PROCEDURE [SP13].[Test round unkown]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')	
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname, chessclubname) VALUES ('tourny1', 'cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND (chessclubname, tournamentname, roundnumber) VALUES ('cc1', 'tourny1', 1)
	EXEC tSQLt.FakeTable 'dbo', 'POULE'	
	INSERT INTO POULE 
	VALUES	('cc1', 'tourny1', 1, 1),
			('cc1', 'tourny1', 1, 2),
			('cc1', 'tourny1', 1, 3)   

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no round with this roundnumber in this tournament'
	
	EXEC SP_GET_POULES_OF_ROUND 'cc1', 'tourny1', 3
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'POULE', 'actual'

END;