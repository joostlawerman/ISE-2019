-- +migrate Up
EXEC tSQLt.NewTestClass 'SP10';

-- +migrate Down
EXEC tSQLt.DropClass 'SP10';

-- +migrate Up
CREATE PROCEDURE SP10.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	INSERT INTO PLAYER 
		VALUES	(1, null, null, null, null, null, null, null, null, null),
				(2, null, null, null, null, null, null, null, null, null)

	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB VALUES ('Schaakvereniging Horst', null, null, null, null)	

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', null, null, null, null, null, null, null, null, null)	

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER'
	INSERT INTO TOURNAMENT_PLAYER VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 0)	
END;


-- +migrate Up
CREATE PROCEDURE [SP10].[Test if paid is updated]
AS 
BEGIN
	--Arrange
	CREATE TABLE expected(    
		chessclubname  VARCHAR(100) NOT NULL,
		tournamentname VARCHAR(100) NOT NULL,
		playerid       INT          NOT NULL,
		paid           BIT          NOT NULL
	)

	INSERT INTO expected
	VALUES ('Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1)

	--Act
	EXEC SP_UPDATE_TOURNAMENT_PLAYER_PAID 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 1, 1

	--Assert
	EXEC tSQLt.AssertEqualsTable expected, TOURNAMENT_PLAYER
END;


-- +migrate Up
CREATE PROCEDURE [SP10].[Test if a player is not participating in the tournament]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'This player is not participating in this tournament'

	--Assert
	EXEC SP_UPDATE_TOURNAMENT_PLAYER_PAID 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 2, 1
END;


-- +migrate Up
CREATE PROCEDURE [SP10].[Test if a playerid does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'This playerid does not exist'

	--Assert
	EXEC SP_UPDATE_TOURNAMENT_PLAYER_PAID 'Schaakvereniging Horst', 'Eerste schaaktoernooi', 3, 1
END;


-- +migrate Up
CREATE PROCEDURE [SP10].[Test if a chessclub does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no chessclub with this name'

	--Assert
	EXEC SP_UPDATE_TOURNAMENT_PLAYER_PAID 'Schaakvereniging Deventer', 'Eerste schaaktoernooi', 1, 1
END;


-- +migrate Up
CREATE PROCEDURE [SP10].[Test if a tournament name does not exist]
AS 
BEGIN
	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There is no tournament with this name'

	--Assert
	EXEC SP_UPDATE_TOURNAMENT_PLAYER_PAID 'Schaakvereniging Horst', 'Tweede schaaktoernooi', 1, 1
END;