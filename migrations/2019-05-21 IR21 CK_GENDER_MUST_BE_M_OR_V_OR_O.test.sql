-- +migrate Up
EXEC tSQLt.NewTestClass 'IR21';

-- +migrate Down
EXEC tSQLt.DropClass 'IR21';

-- +migrate Up 
CREATE PROCEDURE IR21.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER'
	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'PLAYER', @ConstraintName = 'CK_GENDER_MUST_BE_M_OR_V_OR_O'
END;

-- +migrate Up
CREATE PROCEDURE [IR21].[Test if gender is A]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectException

	--Act
	INSERT INTO PLAYER
	VALUES (null, null, null, null, null, null, null, null, null, 'A')
END;

-- +migrate Up
CREATE PROCEDURE [IR21].[Test if gender is M]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectNoException

	--Act
	INSERT INTO PLAYER
	VALUES (null, null, null, null, null, null, null, null, null, 'M')
END;

-- +migrate Up
CREATE PROCEDURE [IR21].[Test if gender is V]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectNoException

	--Act
	INSERT INTO PLAYER
	VALUES (null, null, null, null, null, null, null, null, null, 'V')
END;

-- +migrate Up
CREATE PROCEDURE [IR21].[Test if gender is O]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectNoException

	--Act
	INSERT INTO PLAYER
	VALUES (null, null, null, null, null, null, null, null, null, 'O')
END;