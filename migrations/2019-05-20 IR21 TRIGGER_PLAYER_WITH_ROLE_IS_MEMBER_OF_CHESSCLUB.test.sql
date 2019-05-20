-- +migrate Up
EXEC tSQLt.NewTestClass 'IR21';

-- +migrate Down
EXEC tSQLt.DropClass 'IR21';

-- +migrate Up 
CREATE PROCEDURE IR21.SetUp
AS
BEGIN
   	--Arrange
   	EXEC tSQLt.FakeTable 'dbo', 'ROLE'
   	EXEC tSQLt.ApplyTrigger @TableName = 'ROLE', @TriggerName = 'TRIGGER_PLAYER_WITH_ROLE_IS_MEMBER_OF_CHESSCLUB'
 
   	EXEC tSQLt.FakeTable 'dbo', 'PLAYER';  	
   	INSERT INTO PLAYER 
   	VALUES(1, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
          (2, 'Schaakvereniging Deventer', null, null, null, null, null, null, null, null)
END;

-- +migrate Up
CREATE PROCEDURE [IR21].[Test if a player has a role in a chessclub that he/she is a member of]
AS
BEGIN
   	--Assert
   	EXEC tSQLt.ExpectNoException
 
   	--Act
   	INSERT INTO ROLE
   	VALUES (1, 'Schaakvereniging Horst', 'secretaris'),
           (2, 'Schaakvereniging Deventer', 'hoofdman') 
END;

-- +migrate Up 
CREATE PROCEDURE [IR21].[Test if a player has a role in a chessclub that he/she is not a member of]
AS
BEGIN
   	--Assert
   	EXEC tSQLt.ExpectException @ExpectedMessage= 'Only players that are members of a chessclub can have a role in that chessclub'
 
   	--Act
   	INSERT INTO ROLE
   	VALUES (1, 'Schaakvereniging Horst', 'secretaris'),
           (2, 'Schaakvereniging Horst', 'hoofdman') --gaat op deze fout
END;