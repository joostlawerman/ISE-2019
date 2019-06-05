-- +migrate Up
EXEC tSQLt.NewTestClass 'SP9';

-- +migrate Down
EXEC tSQLt.DropClass 'SP9';

-- +migrate Up
CREATE PROCEDURE SP9.SetUp
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB (chessclubname,city,addressline1,postalcode,emailaddress)
	VALUES ('TestClub','Teststad','TestStraat1','7000AB','testclub.test@test.nl')

	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	INSERT INTO PLAYER (playerid,chessclubname,firstname,lastname,addressline1,postalcode,city,birthdate,emailaddress,gender)
	VALUES (1,'TestClub','Test','Tester','TestStraat1','7000AB','Teststad','2000-01-01','test.test@test.nl','M')

END;

-- +migrate Up
CREATE PROCEDURE [SP9].[Test_alles_correct_ingevuld_en_geupdate_player]
AS
BEGIN

	--Act
	CREATE TABLE expected(
    playerid int not null,
	chessclubname varchar(100) not null,
	firstname varchar(50) not null,
	lastname varchar(50) not null,
	addressline1 varchar(100) not null,
	postalcode varchar(6) not null,
	city varchar(100) not null,
	birthdate date not null,
	emailaddress varchar(256) not null,
	gender char(1) not null
	)

	INSERT INTO expected (playerid,chessclubname,firstname,lastname,addressline1,postalcode,city,birthdate,emailaddress,gender)
	VALUES (1,'TestClub','Tester','Test','TestStraat2','7000AB','Teststad','2000-01-01','test2.test@test.nl','V')

	EXEC SP_UPDATE_PLAYER_INFO 1,'TestClub','Tester','Test','TestStraat2','7000AB','Teststad','2000-01-01','test2.test@test.nl','V'

	--Assert
	EXEC tSQLt.AssertEqualsTable 'PLAYER', 'expected'
END;

-- +migrate Up
CREATE PROCEDURE [SP9].[Test_geen_playerid_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Vul een playerid in.'

	EXEC SP_UPDATE_PLAYER_INFO null,'TestClub','Tester','Test','TestStraat2','7000AB','Teststad','2000-01-01','test2.test@test.nl','V'
END;

-- +migrate Up
CREATE PROCEDURE [SP9].[Test_niet_bestaand_playerid_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde speler bestaat niet.'

	EXEC SP_UPDATE_PLAYER_INFO 4,'TestClub','Tester','Test','TestStraat2','7000AB','Teststad','2000-01-01','test2.test@test.nl','V'
END;

-- +migrate Up
CREATE PROCEDURE [SP9].[Test_geen_bestaande_chessclub_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde schaakclub bestaat niet.'

	EXEC SP_UPDATE_PLAYER_INFO 1,'Test','Tester','Test','TestStraat2','7000AB','Teststad','2000-01-01','test2.test@test.nl','V'
END;

-- +migrate Up
CREATE PROCEDURE [SP9].[Test_datum_is_na_vandaag]
AS
BEGIN
	DECLARE @DATE DATE
	SELECT @DATE = DATEADD(year, 1, getDate())

	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De datum van geboorte moet voor vandaag zijn.'

	EXEC SP_UPDATE_PLAYER_INFO 1,'TestClub','Tester','Test','TestStraat2','7000AB','Teststad',@DATE,'test2.test@test.nl','V'
END;
