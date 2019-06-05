-- +migrate Up
EXEC tSQLt.NewTestClass 'IR22';

-- +migrate Down
EXEC tSQLt.DropClass 'IR22';

-- +migrate Up 
CREATE PROCEDURE IR22.SetUp
AS
BEGIN
   	--Arrange
	EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCHMOVE'
	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'CHESSMATCHMOVE', @ConstraintName = 'CK_COLOUR_MUST_BE_B_OR_W'
END;

-- +migrate Up
CREATE PROCEDURE [IR22].[Test_succeed_colour_W]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectNoException

	--Act
	INSERT INTO CHESSMATCHMOVE (matchno,moveno,colour,destination)
	VALUES (null, null, 'W',null)
END;

-- +migrate Up
CREATE PROCEDURE [IR22].[Test_succeed_colour_B]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectNoException

	--Act
	INSERT INTO CHESSMATCHMOVE (matchno,moveno,colour,destination)
	VALUES (null, null, 'B',null)
END;

-- +migrate Up
CREATE PROCEDURE [IR22].[Test_fail_colour_G]
AS
BEGIN
	--Assemble
	EXEC tSQLt.ExpectException

	--Act
	INSERT INTO CHESSMATCHMOVE
	VALUES (null, null, 'G',null)
END;