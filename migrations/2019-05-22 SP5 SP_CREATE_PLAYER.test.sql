-- +migrate Up
EXEC tSQLt.NewTestClass 'SP5';

-- +migrate Down
EXEC tSQLt.DropClass 'SP5';

-- +migrate Up
CREATE PROCEDURE [SP5].[test insert iets]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'

	--Act
	EXEC SP_CREATE_PLAYER 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M'

	--Assert
	CREATE TABLE expected (
    playerid      INT          NOT NULL,
    chessclubname VARCHAR(100) NULL,
    firstname     VARCHAR(50)  NOT NULL,
    lastname      VARCHAR(50)  NOT NULL,
    addressline1  VARCHAR(100) NOT NULL,
    postalcode    VARCHAR(6)   NOT NULL,
    city          CHAR(100)    NOT NULL,
    birthdate     DATETIME     NOT NULL,
    emailaddress  VARCHAR(256) NOT NULL,
    gender        CHAR(1)      NOT NULL
	)

	INSERT INTO expected VALUES (1, 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M')

	EXEC tSQLt.AssertEqualsTable 'expected', 'PLAYER'
END;

-- +migrate Up
CREATE PROCEDURE [SP5].[test insert playerid 4]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'

	--Act
	EXEC SP_CREATE_PLAYER 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M'
	EXEC SP_CREATE_PLAYER 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M'
	EXEC SP_CREATE_PLAYER 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M'
	EXEC SP_CREATE_PLAYER 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M'

	--Assert
	CREATE TABLE expected (
    playerid      INT          NOT NULL,
    chessclubname VARCHAR(100) NULL,
    firstname     VARCHAR(50)  NOT NULL,
    lastname      VARCHAR(50)  NOT NULL,
    addressline1  VARCHAR(100) NOT NULL,
    postalcode    VARCHAR(6)   NOT NULL,
    city          CHAR(100)    NOT NULL,
    birthdate     DATETIME     NOT NULL,
    emailaddress  VARCHAR(256) NOT NULL,
    gender        CHAR(1)      NOT NULL
	)

	INSERT INTO expected VALUES (1, 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M')
	INSERT INTO expected VALUES (2, 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M')
	INSERT INTO expected VALUES (3, 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M')
	INSERT INTO expected VALUES (4, 'CC1', 'bla', 'blah', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22', 'bla@bla.com', 'M')

	EXEC tSQLt.AssertEqualsTable 'expected', 'PLAYER'
END;