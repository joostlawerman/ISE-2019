-- +migrate Up
EXEC tSQLt.NewTestClass 'SP19';

-- +migrate Down
EXEC tSQLt.DropClass 'SP19';

-- +migrate Up
CREATE PROCEDURE [SP19].[Test if a role is linked to a player]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'ROLE'	

	CREATE TABLE expected(    
		playerid      INT          NOT NULL,
		chessclubname VARCHAR(100) NOT NULL,
		role          VARCHAR(50)  NULL
	)

	INSERT INTO expected
	VALUES (1, 'Schaakvereniging Horst', 'Secretaris')

	--Act
	EXEC SP_LINK_ROLE_TO_PLAYER 1, 'Schaakvereniging Horst', 'Secretaris'

	--Assert
	EXEC tSQLt.AssertEqualsTable expected, ROLE
END;

-- +migrate Up
CREATE PROCEDURE [SP19].[Test if a player can not be linked multiple time to the same role in a chessclub]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'ROLE'
	INSERT INTO ROLE VALUES (1, 'Schaakvereniging Horst', 'Secretaris')	

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'This player already has this role in the chosen chessclub'

	--Assert
	EXEC SP_LINK_ROLE_TO_PLAYER 1, 'Schaakvereniging Horst', 'Secretaris'
END;

-- +migrate Up
CREATE PROCEDURE [SP19].[Test if a player can be linked to multiple roles in a chessclub]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'ROLE'
	INSERT INTO ROLE VALUES (1, 'Schaakvereniging Horst', 'Secretaris')	

	--Act
	EXEC tSQLt.ExpectNoException

	--Assert
	EXEC SP_LINK_ROLE_TO_PLAYER 1, 'Schaakvereniging Horst', 'Penningmeester'
END;