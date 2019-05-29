-- +migrate Down
EXEC tSQLt.DropClass 'SP16';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP16';

-- +migrate Up
CREATE PROCEDURE [SP16].[Test blabla]
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

	SELECT *
		INTO expected
        FROM POULE
		WHERE roundnumber = 1

	--Act
	CREATE TABLE actual (
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		roundnumber    INT          NOT NULL,
		pouleno        INT          NOT NULL
	)
	
	INSERT INTO actual EXEC SP_GET_POULES_OF_ROUND 'cc1', 'tourny1', 1
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'

END;