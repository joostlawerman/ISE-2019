-- +migrate Up
EXEC tSQLt.NewTestClass 'SP1';

-- +migrate Down
EXEC tSQLt.DropClass 'SP1';

-- +migrate Up
CREATE PROCEDURE [SP1].[test insert een goed toernooi]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	INSERT INTO CHESSCLUB (chessclubname) VALUES ('CC1')
	INSERT INTO CONTACTPERSON (contactname) VALUES ('gekkenaam')

	--Act
	EXEC SP_CREATE_TOURNAMENT 'CC1', 'tourny1', 'gekkenaam', '2019-05-22', '2019-05-23', '10', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22'

	--Assert
	CREATE TABLE expected (
    chessclubname        VARCHAR(100) NOT NULL,
    tournamentname       VARCHAR(100) NOT NULL,
    winner               INT          NULL,
    contactname          VARCHAR(101) NOT NULL,
    starts               DATETIME     NOT NULL,
    ends                 DATETIME     NULL,
    registrationfee      MONEY        NOT NULL,
    addressline1         VARCHAR(100) NOT NULL,
    postalcode           VARCHAR(6)   NOT NULL,
    city                 CHAR(100)    NOT NULL,
    registrationdeadline DATETIME     NOT NULL,
	)

	INSERT INTO expected (chessclubname, tournamentname, contactname, starts, ends, registrationfee, addressline1, postalcode, city, registrationdeadline) 
	VALUES ('CC1', 'tourny1', 'gekkenaam', '2019-05-22', '2019-05-23', 10, 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22')

	EXEC tSQLt.AssertEqualsTable 'expected', 'TOURNAMENT'
END;

-- +migrate Up
CREATE PROCEDURE [SP1].[test insert een toernooi met slechte chessclub]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	INSERT INTO CONTACTPERSON (contactname) VALUES ('gekkenaam')

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage= 'Chessclub is not known. Please register the chessclub first.'

	EXEC SP_CREATE_TOURNAMENT 'CC1', 'tourny1', 'gekkenaam', '2019-05-22', '2019-05-23', '10', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22'
END;

-- +migrate Up
CREATE PROCEDURE [SP1].[test insert een toernooi met slechte contactperson]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	INSERT INTO CHESSCLUB (chessclubname) VALUES ('CC1')

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage= 'Contactperson is not known. Please register the contactperson first.'

	EXEC SP_CREATE_TOURNAMENT 'CC1', 'tourny1', 'gekkenaam', '2019-05-22', '2019-05-23', '10', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22'
END;