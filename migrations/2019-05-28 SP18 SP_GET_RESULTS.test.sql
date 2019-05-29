-- +migrate Up
EXEC tSQLt.NewTestClass 'SP18';

-- +migrate Down
EXEC tSQLt.DropClass 'SP18';

-- +migrate Up
CREATE PROCEDURE SP18.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB VALUES ('Schaakvereniging Horst', null, null, null, null)	

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', null, null, null, null, null, null, null, null, null)	

	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH_OF_POULE'
	INSERT INTO CHESSMATCH_OF_POULE 
		VALUES	(1, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1, 2, 3, 'zwart'),	
				(2, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 3, 5, 6, 'zwart'),
				(17, 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 5, 1, 4, 3, 'wit')
END;


-- +migrate Up
CREATE PROCEDURE [SP18].[Test resulteds are selected]
AS 
BEGIN
	--Act
	SELECT *
		INTO expected
        FROM CHESSMATCH_OF_POULE
		WHERE roundnumber = 1

	CREATE TABLE actual(    
		matchno        INT          NOT NULL,
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		roundnumber    INT          NOT NULL,
		pouleno        INT          NOT NULL,
		playeridwhite  INT          NOT NULL,
		playeridblack  INT          NOT NULL,
		result         CHAR(6)      DEFAULT NULL,
	)
		
	INSERT INTO actual EXEC SP_GET_RESULTS 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1

	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
END;


-- +migrate Up
CREATE PROCEDURE [SP18].[Test there is no round with this roundnumber in this tournament]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no round with this roundnumber in this tournament'

	--Assert
	EXEC SP_GET_RESULTS 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 19
END;


-- +migrate Up
CREATE PROCEDURE [SP18].[Test if a chessclub does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	--Assert
	EXEC SP_GET_RESULTS 'Schaakvereniging Deventer', 'Eerste schaaktoernooi', 1
END;


-- +migrate Up
CREATE PROCEDURE [SP18].[Test if a tournament name does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	--Assert
	EXEC SP_GET_RESULTS 'Schaakvereniging Horst', 'Tweede schaaktoernooi', 1
END;