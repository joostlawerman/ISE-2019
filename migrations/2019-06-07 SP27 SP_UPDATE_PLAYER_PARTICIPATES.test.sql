-- +migrate Up
EXEC tSQLt.NewTestClass 'SP27';

-- +migrate Down
EXEC tSQLt.DropClass 'SP27';

-- +migrate Up
CREATE PROCEDURE SP27.SetUp AS
BEGIN
   -- Arrange
   	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB 
	VALUES	('Schaakvereniging Horst', null, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	INSERT INTO PLAYER 
	VALUES	(1, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
			(2, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null),
			(3, 'Schaakvereniging Horst', null, null, null, null, null, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT 
	VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', null, null, null, null, null, null, null, null, null)	

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER'	
	INSERT INTO TOURNAMENT_PLAYER
	VALUES	('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, null),
			('Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, null)
END;

-- +migrate Up
CREATE PROCEDURE [SP27].[Test if a player is participating]
AS 
BEGIN
	--Act
	SELECT * INTO actual FROM TOURNAMENT_PLAYER
	INSERT INTO actual VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', 3, 0)
	
	EXEC SP_UPDATE_PLAYER_PARTICIPATES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 3, 1

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_PLAYER', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE [SP27].[Test if a player is not participating]
AS 
BEGIN
	--Act
	SELECT * INTO actual FROM TOURNAMENT_PLAYER
	DELETE FROM actual WHERE playerid = 1
	
	EXEC SP_UPDATE_PLAYER_PARTICIPATES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 0

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT_PLAYER', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE [SP27].[Test if a chessclub does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	--Assert
	EXEC SP_UPDATE_PLAYER_PARTICIPATES 'Schaakvereniging Flevoland', 'Eerste schaaktoernooi', 1, 0
END;

-- +migrate Up
CREATE PROCEDURE [SP27].[Test if a tournament name does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	--Assert
	EXEC SP_UPDATE_PLAYER_PARTICIPATES 'Schaakvereniging Horst', 'Tweede schaaktoernooi', 1, 0
END;

-- +migrate Up
CREATE PROCEDURE [SP27].[Test if a playerid does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no player with this playerid'

	--Assert
	EXEC SP_UPDATE_PLAYER_PARTICIPATES 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 4, 0
END;