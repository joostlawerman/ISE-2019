-- +migrate Up
EXEC tSQLt.NewTestClass 'SP3';

-- +migrate Down
EXEC tSQLt.DropClass 'SP3';

-- +migrate Up
CREATE PROCEDURE [SP3].[test select iets]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	INSERT INTO TOURNAMENT VALUES ('CC1', 'tourny1', 1, 'gekkenaam', '2019-05-22', '2019-05-23', 10, 'blastraat', '1234AB', 'Apeldoorn', '2019-05-22')

	--Act
	CREATE TABLE actual (
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

	INSERT INTO actual EXEC GET_TOURNAMENT_INFO 'tourny1', 'CC1'

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'actual'
END;
