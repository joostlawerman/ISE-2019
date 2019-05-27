-- +migrate Up
EXEC tSQLt.NewTestClass 'SP7';

-- +migrate Down
EXEC tSQLt.DropClass 'SP7';

-- +migrate Up
CREATE PROCEDURE [SP7].[Test if a chessclub is created]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'	

	CREATE TABLE expected(    
		chessclubname VARCHAR(100) NOT NULL,
		city          VARCHAR(100) NOT NULL,
		addressline1  VARCHAR(100) NOT NULL,
		postalcode    VARCHAR(6)   NOT NULL,
		emailaddress  VARCHAR(256) NOT NULL
	)

	INSERT INTO expected
	VALUES ('Schaakvereniging Horst', 'Horst', 'Bloemenlaan 34', '6739TH', 'schaakverening.horst@gmail.com')

	--Act
	EXEC SP_CREATE_CHESSCLUB 'Schaakvereniging Horst', 'Horst', 'Bloemenlaan 34', '6739TH', 'schaakverening.horst@gmail.com'

	--Assert
	EXEC tSQLt.AssertEqualsTable expected, CHESSCLUB
END;

-- +migrate Up
CREATE PROCEDURE [SP7].[Test if a chessclub is already in the database]
AS 
BEGIN
	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	INSERT INTO CHESSCLUB VALUES ('Schaakvereniging Horst', 'Horst', 'Bloemenlaan 34', '6739TH', 'schaakverening.horst@gmail.com')	

	--Act
	EXEC tSQLt.ExpectException @ExpectedMessage = 'There already is a chessclub with the same name'
	
	--Assert
	EXEC SP_CREATE_CHESSCLUB 'Schaakvereniging Horst', 'Horst', 'Bloemenlaan 34', '6739TH', 'schaakverening.horst@gmail.com'
END;