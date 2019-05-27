-- +migrate Up
EXEC tSQLt.NewTestClass 'SP8';

-- +migrate Down
EXEC tSQLt.DropClass 'SP8';

-- +migrate Up
CREATE PROCEDURE [SP8].[test select speler info]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'

	INSERT INTO PLAYER VALUES (1, 'CC1', 'gekke', 'boy', 'gekkestraat1', '1234AB', 'Apeldoorn', '1998-03-02', 'gekkeboy@gmail.com', 'M')

	--Act
	CREATE TABLE actual (
    playerid      INT          NOT NULL,
    chessclubname VARCHAR(100) NULL,
    firstname     VARCHAR(50)  NOT NULL,
    lastname      VARCHAR(50)  NOT NULL,
    addressline1  VARCHAR(100) NOT NULL,
    postalcode    VARCHAR(6)   NOT NULL,
    city          VARCHAR(100)    NOT NULL,
    birthdate     DATE         NOT NULL,
    emailaddress  VARCHAR(256) NOT NULL,
    gender        CHAR(1)      NOT NULL
	)

	INSERT INTO actual EXEC SP_GET_PLAYER_INFO 1

	--Assert
	EXEC tSQLt.AssertEqualsTable 'PLAYER', 'actual'
END;