-- +migrate Up
EXEC tSQLt.NewTestClass 'SP4';

-- +migrate Down
EXEC tSQLt.DropClass 'SP4';

-- +migrate Up
CREATE PROCEDURE [SP4].[Test get all tournament names]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'	
	INSERT INTO TOURNAMENT 
	VALUES	(null, 'eerste tournooi', null, null, null, null, null, null, null, null, null),
			(null, 'tweede tournooi', null, null, null, null, null, null, null, null, null)    

	--Act
	CREATE TABLE actual (
		chessclubname        VARCHAR(100) NULL,
		tournamentname       VARCHAR(100) NULL,
		winner               INT          NULL,
		contactname          VARCHAR(101) NULL,
		starts               DATETIME     NULL,
		ends                 DATETIME     NULL,
		registrationfee      MONEY        NULL,
		addressline1         VARCHAR(100) NULL,
		postalcode           VARCHAR(6)   NULL,
		city                 CHAR(100)    NULL,
		registrationdeadline DATETIME     NULL,
	)
	
	INSERT INTO actual (tournamentname) EXEC SP_GET_TOURNAMENT_NAMES 
 
	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'actual'

END;