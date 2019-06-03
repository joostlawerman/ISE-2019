-- +migrate Up
EXEC tSQLt.NewTestClass 'SP2';

-- +migrate Down
EXEC tSQLt.DropClass 'SP2';

-- +migrate Up
CREATE PROCEDURE SP2.SetUp
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'
	INSERT INTO CONTACTPERSON (contactname,emailaddress,phonenumber)
	VALUES ('Testo Tset','Tset.test@test.nl','2299384887')

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER'
	INSERT INTO TOURNAMENT_PLAYER (chessclubname,tournamentname,playerid,paid)
	VALUES ('TestClub','TestToernooi',1,1)

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (chessclubname, tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	VALUES ('TestClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-01 01:00:00', '2019-05-04 02:00:00', 10.00, 'TestStraat1', '7000AB', 'Teststad', '2019-05-01')

END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_alles_correct_ingevuld_en_geupdate]
AS
BEGIN

	--Act
	CREATE TABLE expected(
    chessclubname        VARCHAR(100) NOT NULL,
    tournamentname       VARCHAR(100) NOT NULL,
    winner               INT          NULL,
    contactname          VARCHAR(101) NOT NULL,
    starts               DATETIME     NOT NULL,
    ends                 DATETIME     NULL,
    registrationfee      MONEY        NOT NULL,
    addressline1         VARCHAR(100) NOT NULL,
    postalcode           VARCHAR(6)   NOT NULL,
    city                 VARCHAR(100)    NOT NULL,
    registrationdeadline DATETIME     NOT NULL,
	)

	INSERT INTO expected (chessclubname, tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	VALUES ('TestClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-03 01:00:00', '2019-05-04 02:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03')

	EXEC SP_UPDATE_TOURNAMENT 'TestClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'expected'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_geen_schaakclub_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Vul een schaakclub en toernooinaam in.'

	EXEC SP_UPDATE_TOURNAMENT null, 'TestToernooi', 1, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_geen_toernooinaam_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Vul een schaakclub en toernooinaam in.'

	EXEC SP_UPDATE_TOURNAMENT 'TestClub', null, 1, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_schaakclub_bestaat_niet]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde schaakclub bestaat niet.'

	EXEC SP_UPDATE_TOURNAMENT 'GeenClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_schaaktoernooi_bestaat_niet]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Het ingevulde schaaktoernooi voor de ingevulde schaakclub bestaat niet.'

	EXEC SP_UPDATE_TOURNAMENT 'TestClub', 'GeenToernooi', 1, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_contactpersoon_bestaat_niet]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde contactpersoon bestaat niet.'

	EXEC SP_UPDATE_TOURNAMENT 'TestClub', 'TestToernooi', 1, 'Geen Persoon', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;

-- +migrate Up
CREATE PROCEDURE [SP2].[Test_winner_neemt_geen_deel_aan_toernooi]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde winnaar doet niet mee aan het geselecteerde toernooi.'

	EXEC SP_UPDATE_TOURNAMENT 'TestClub', 'TestToernooi', 2, 'Testo Tset', '2019-05-03 01:00:00', 10.00, 'StraatTest22', '7033AG', 'StadTest', '2019-05-03'
END;