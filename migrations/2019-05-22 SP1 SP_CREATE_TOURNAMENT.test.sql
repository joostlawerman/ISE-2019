-- +migrate Up
EXEC tSQLt.NewTestClass 'SP1';

-- +migrate Down
EXEC tSQLt.DropClass 'SP1';

-- +migrate Up
CREATE PROCEDURE [SP1].[test insert iets]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	--Act
	EXEC SP_CREATE_TOURNAMENT 'CC1', 'tourny1', 1, 'gekkenaam', '2019-05-22', '2019-05-23', '10', 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22'

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

	INSERT INTO expected VALUES ('CC1', 'tourny1', 1, 'gekkenaam', '2019-05-22', '2019-05-23', 10, 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22')

	EXEC tSQLt.AssertEqualsTable 'expected', 'TOURNAMENT'
END;