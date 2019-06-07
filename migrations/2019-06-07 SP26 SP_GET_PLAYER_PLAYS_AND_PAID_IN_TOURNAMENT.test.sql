-- +migrate Up
EXEC tSQLt.NewTestClass 'SP26';

-- +migrate Down
EXEC tSQLt.DropClass 'SP26';

-- +migrate Up
CREATE PROCEDURE [SP26].SetUp
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline)
	VALUES
    ('testclub', 'testtoernooi', 'testcontact', dateadd(DAY, 10, getdate()), dateadd(DAY, 11, getdate()), 10,
     'teststraat 11', '2222BB', 'teststad', dateadd(DAY, 9, getdate()));

	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	INSERT INTO PLAYER (playerid,chessclubname,firstname,lastname,addressline1,postalcode,city,birthdate,emailaddress,gender)
	VALUES 
	(1,'testclub','testie','tester','testlaan 11','2222EP','teststad','2000-01-01','test@test.com','V'),
	(2,'testclub','testi','testere','testlaan 12','3333ES','teststad','2000-01-01','test@test.com','V'),
	(3,'testclub','teste','testeren','testlaan 13','4444ED','teststad','2000-01-01','test@test.com','M')

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER'
	INSERT INTO TOURNAMENT_PLAYER (chessclubname,tournamentname,playerid,paid) VALUES
	('testclub','testtoernooi',1,1),
	('testclub','testtoernooi',2,0)
END

-- +migrate Up
CREATE PROCEDURE [SP26].[test_player_participates_paid]
AS
BEGIN
	
	--Act
	CREATE TABLE expected (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)
	INSERT INTO expected (playerid,participates,paid) VALUES
	(1,1,1)

	--Act
	CREATE TABLE actual (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)

	INSERT INTO actual EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'testclub','testtoernooi',1

	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE [SP26].[test_player_participates_not_paid]
AS
BEGIN
	
	--Act
	CREATE TABLE expected (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)
	INSERT INTO expected (playerid,participates,paid) VALUES
	(2,1,0)

	--Act
	CREATE TABLE actual (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)

	INSERT INTO actual EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'testclub','testtoernooi',2

	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE [SP26].[test_player_doesnt_participate]
AS
BEGIN
	
	--Act
	CREATE TABLE expected (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)
	INSERT INTO expected (playerid,participates,paid) VALUES
	(3,0,0)

	--Act
	CREATE TABLE actual (
		playerid      INT    NOT NULL,
		participates  BIT	 NOT NULL,
		paid		  BIT	 NOT NULL
	)

	INSERT INTO actual EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'testclub','testtoernooi',3

	--Assert
	EXEC tSQLt.AssertEqualsTable 'expected', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE [SP26].[test_error_tournament_doesnt_exist]
AS
BEGIN
	
	exec tsqlt.ExpectException 'There is no tournament with this name', 16, 1

	--Assert
	EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'testclub','test',1
END;

-- +migrate Up
CREATE PROCEDURE [SP26].[test_error_club_doesnt_exist]
AS
BEGIN
	
	exec tsqlt.ExpectException 'There is no chessclub with this name', 16, 1

	--Assert
	EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'test','testtoernooi',1
END;

-- +migrate Up
CREATE PROCEDURE [SP26].[test_error_player_doesnt_exist]
AS
BEGIN
	
	exec tsqlt.ExpectException 'The playerid does not exists', 16, 1

	--Assert
	EXEC SP_GET_PLAYER_PLAYS_AND_PAID_IN_TOURNAMENT 'testclub','testtoernooi',10
END;