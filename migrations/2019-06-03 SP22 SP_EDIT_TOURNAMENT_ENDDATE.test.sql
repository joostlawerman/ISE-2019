-- +migrate Up
EXEC tSQLt.NewTestClass 'SP22';

-- +migrate Down
EXEC tSQLt.DropClass 'SP22';

-- +migrate Up
CREATE PROCEDURE SP22.SetUp
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	INSERT INTO TOURNAMENT (chessclubname, tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	VALUES ('TestClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-01 01:00:00', '2019-02-14 02:00:00', 10.00, 'TestStraat1', '7000AB', 'Teststad', '2019-05-01')

END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_alles_correct_ingevuld_en_geupdate]
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
    registrationdeadline DATETIME     NOT NULL
	)

	INSERT INTO expected (chessclubname, tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	VALUES ('TestClub', 'TestToernooi', 1, 'Testo Tset', '2019-05-01 01:00:00', '2020-05-04 02:00:00', 10.00, 'TestStraat1', '7000AB', 'Teststad', '2019-05-01')

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE 'TestClub', 'TestToernooi', '2020-05-04 02:00:00'

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'expected'
END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_geen_schaakclub_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Vul een schaakclub en toernooinaam in.'

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE null, 'TestToernooi', '2019-05-04 02:00:00'
END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_geen_toernooinaam_ingevuld]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Vul een schaakclub en toernooinaam in.'

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE 'TestClub', null, '2019-05-04 02:00:00'
END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_schaakclub_bestaat_niet]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde schaakclub bestaat niet.'

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE 'Test', 'TestToernooi', '2019-05-04 02:00:00'
END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_schaaktoernooi_bestaat_niet]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'Het ingevulde schaaktoernooi voor de ingevulde schaakclub bestaat niet.'

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE 'TestClub', 'GeenToernooi', '2019-05-04 02:00:00'
END;

-- +migrate Up
CREATE PROCEDURE [SP22].[Test_Ends_voor_starts]
AS
BEGIN
	--Assert
	EXEC tSQLt.ExpectException @ExpectedMessage = 'De ingevulde eindtijd moet na de begintijd zijn.'

	EXEC SP_UPDATE_TOURNAMENT_ENDDATE 'TestClub', 'TestToernooi', '2011-05-04 02:00:00'
END;