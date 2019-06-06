-- +migrate Up
EXEC tSQLt.NewTestClass 'IR15';

-- +migrate Down
EXEC tSQLt.DropClass 'IR15';

-- +migrate Up 
CREATE PROCEDURE IR15.SetUp
AS
BEGIN
   	--Arrange
   	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'
   	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED'
 
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH_OF_POULE'

   	EXEC tSQLt.FakeTable 'dbo', 'POULE'  	
   	INSERT INTO POULE 
   	VALUES('Schaakvereniging Horst', 'Eerste toernooi', 1, 1),
          ('Schaakvereniging Horst', 'Eerste toernooi', 1, 2)
END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in another poule has started with insert]
AS
BEGIN
   	INSERT INTO CHESSMATCH_OF_POULE 
   	VALUES(null, 'Schaakvereniging Horst', 'Eerste toernooi', 1, 2, null, null, 'remise')

   	--Assert
   	EXEC tSQLt.ExpectException @ExpectedMessage= 'A poule can not be changed when a match in that poule has started'
  
   	--Act
   	INSERT INTO TOURNAMENT_PLAYER_OF_POULE
   	VALUES ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 1),
           ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 2) 
END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule cannot be changed when a match in that poule has started with update]
AS
BEGIN
   	INSERT INTO CHESSMATCH_OF_POULE 
   	VALUES(null, 'Schaakvereniging Horst', 'Eerste toernooi', 1, 2, null, null, null)

   	--Assert
   	EXEC tSQLt.ExpectException @ExpectedMessage= 'A poule can not be changed when a match in that poule has started'
  
   	--Act
   	INSERT INTO TOURNAMENT_PLAYER_OF_POULE
   	VALUES ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 1),
           ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 2) 
END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in that poule not yet started with update]
AS
BEGIN
   	--Assert
   	EXEC tSQLt.ExpectNoException
  
   	--Act
   	INSERT INTO TOURNAMENT_PLAYER_OF_POULE
   	VALUES ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 1),
           ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 2) 
END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in another poule has started with update]
AS
BEGIN
   	INSERT INTO CHESSMATCH_OF_POULE
   	VALUES(null, 'Schaakvereniging Horst', 'Eerste toernooi', 1, 3, null, null, null)

   	--Assert
   	EXEC tSQLt.ExpectNoException
  
   	--Act
   	INSERT INTO TOURNAMENT_PLAYER_OF_POULE
   	VALUES ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 1),
           ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 2) 
END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a tournamentname can be changed when a match in the poule has started with update]
AS
BEGIN
   	INSERT INTO CHESSMATCH_OF_POULE 
   	VALUES(null, 'Schaakvereniging Horst', 'Eerste toernooi', 1, 3, null, null, 'remise')

   	--Assert
   	EXEC tSQLt.ExpectNoException
  
   	--Act
   	INSERT INTO TOURNAMENT_PLAYER_OF_POULE
   	VALUES ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 1),
           ('Schaakvereniging Horst', null, 'Eerste toernooi', 1, 2) 
END;
