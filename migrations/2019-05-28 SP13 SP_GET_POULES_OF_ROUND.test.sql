-- +migrate Up
EXEC tSQLt.NewTestClass 'SP13';

-- +migrate Down
EXEC tSQLt.DropClass 'SP13';

-- +migrate Up
CREATE PROCEDURE [SP13].[Test get all poules of a round]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'POULE'	
	INSERT INTO POULE 
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
	
	INSERT INTO actual EXEC SP_GET_POULES_OF_ROUND
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'POULE', 'actual'

END;