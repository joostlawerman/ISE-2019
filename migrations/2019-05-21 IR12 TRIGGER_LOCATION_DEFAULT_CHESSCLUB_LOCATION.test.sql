-- +migrate Up
EXEC tSQLt.NewTestClass 'IR12';

-- +migrate Down
EXEC tSQLt.DropClass 'IR12';

-- +migrate Up
CREATE PROCEDURE [IR12].[test location empty]
AS
BEGIN
	--Assemble
	DECLARE @expected1 varchar
	DECLARE @actual1 varchar
	DECLARE @expected2 varchar
	DECLARE @actual2 varchar
	DECLARE @expected3 varchar
	DECLARE @actual3 varchar

	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT', @triggername = 'TRIGGER_LOCATION_DEFAULT_CHESSCLUB_LOCATION'

	INSERT INTO CHESSCLUB (chessclubname, city, addressline1, postalcode) VALUES ('CC1', 'Apeldoorn', 'blastraat1', '1234AB')

	--Act
	INSERT INTO TOURNAMENT (tournamentname, chessclubname, city, addressline1, postalcode) VALUES ('tourny1', 'CC1', NULL, NULL, NULL)

	--Assert
	SELECT @expected1 = addressline1 FROM CHESSCLUB
	SELECT @actual1 = addressline1 FROM TOURNAMENT
	SELECT @expected2 = city FROM CHESSCLUB
	SELECT @actual2 = city FROM TOURNAMENT
	SELECT @expected3 = postalcode FROM CHESSCLUB
	SELECT @actual3 = postalcode FROM TOURNAMENT

	EXEC tSQLt.AssertEquals @expected1, @actual1
	EXEC tSQLt.AssertEquals @expected2, @actual2
	EXEC tSQLt.AssertEquals @expected3, @actual3
END;

-- +migrate Up
CREATE PROCEDURE [IR12].[test location not empty]
AS
BEGIN
	--Assemble
	DECLARE @expected1 varchar
	DECLARE @actual1 varchar
	DECLARE @expected2 varchar
	DECLARE @actual2 varchar
	DECLARE @expected3 varchar
	DECLARE @actual3 varchar

	EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT', @triggername = 'TRIGGER_LOCATION_DEFAULT_CHESSCLUB_LOCATION'

	INSERT INTO CHESSCLUB (chessclubname, city, addressline1, postalcode) VALUES ('CC1', 'Apeldoorn', 'blastraat1', '1234AB')

	--Act
	INSERT INTO TOURNAMENT (tournamentname, chessclubname, city, addressline1, postalcode) VALUES ('tourny1', 'CC1', 'Deventer', 'nietstraat2', '4321BA')

	--Assert
	SELECT @expected1 = addressline1 FROM CHESSCLUB
	SELECT @actual1 = addressline1 FROM TOURNAMENT
	SELECT @expected2 = city FROM CHESSCLUB
	SELECT @actual2 = city FROM TOURNAMENT
	SELECT @expected3 = postalcode FROM CHESSCLUB
	SELECT @actual3 = postalcode FROM TOURNAMENT

	EXEC tSQLt.AssertNotEquals @expected1, @actual1
	EXEC tSQLt.AssertNotEquals @expected2, @actual2
	EXEC tSQLt.AssertNotEquals @expected3, @actual3
END;

exec tSQLt.run IR12