-- +migrate Down
EXEC tSQLt.DropClass 'SP14';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP14';

-- +migrate Up
CREATE PROCEDURE [SP14].[Test get all rounds from tournament]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname) VALUES ('tourny1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'	
	INSERT INTO TOURNAMENT_ROUND 
	VALUES	('cc1', 'tourny1', 1, 'roundrobin', '2019-05-28', NULL),
			('cc1', 'tourny1', 2, 'roundrobin', '2019-05-28', NULL),  

	--Act
	CREATE TABLE actual (
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		roundnumber    INT          NOT NULL,
		system         VARCHAR(25)  NOT NULL,
		starts         DATETIME     NOT NULL,
		ends           DATETIME     NULL
	)
	
	INSERT INTO actual EXEC SP_GET_ROUNDS 'cc1', 'tourny1'
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_ROUND', 'actual'

END;

-- +migrate Up
CREATE PROCEDURE [SP14].[Test chessclub bestaat niet]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname) VALUES ('tourny1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'	
	INSERT INTO TOURNAMENT_ROUND 
	VALUES	('cc1', 'tourny1', 1, 'roundrobin', '2019-05-28', NULL),
			('cc1', 'tourny1', 2, 'roundrobin', '2019-05-28', NULL),
	
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	INSERT INTO actual EXEC SP_GET_ROUNDS 'blabla', 'tourny1'
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_ROUND', 'actual'

END;

-- +migrate Up
CREATE PROCEDURE [SP14].[Test tourny bestaat niet]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname) VALUES ('cc1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (tournamentname) VALUES ('tourny1')
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'	
	INSERT INTO TOURNAMENT_ROUND 
	VALUES	('cc1', 'tourny1', 1, 'roundrobin', '2019-05-28', NULL),
			('cc1', 'tourny1', 2, 'roundrobin', '2019-05-28', NULL),
	
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	INSERT INTO actual EXEC SP_GET_ROUNDS 'cc1', 'blabla'
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_ROUND', 'actual'

END;