-- +migrate Down
EXEC tSQLt.DropClass 'SP14';

-- +migrate Up
EXEC tSQLt.NewTestClass 'SP14';

-- +migrate Up
CREATE PROCEDURE [SP14].[Test get all rounds from tournament]
AS 
BEGIN
	--Arrange
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
	
	INSERT INTO actual EXEC SP_GET_ROUNDS
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_ROUND', 'actual'

END;