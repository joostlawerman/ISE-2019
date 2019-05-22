-- +migrate Up
EXEC tSQLt.NewTestClass 'IR18';

-- +migrate Down
EXEC tSQLt.DropClass 'IR18';

-- +migrate Up
CREATE PROCEDURE [IR18].[test phonenumber longer than 10]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'CONTACTPERSON', @ConstraintName = 'CK_PHONE_NUMBER_TEN_NUMBERS'

	EXEC tSQLt.ExpectException
	--Act
	INSERT INTO CONTACTPERSON (phonenumber) VALUES ('01234567890123')
END;

-- +migrate Up
CREATE PROCEDURE [IR18].[test phonenumber shorter than 10]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'CONTACTPERSON', @ConstraintName = 'CK_PHONE_NUMBER_TEN_NUMBERS'

	EXEC tSQLt.ExpectException
	--Act
	INSERT INTO CONTACTPERSON (phonenumber) VALUES ('01234567')
END;

CREATE PROCEDURE [IR18].[test phonenumber is 10]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'CONTACTPERSON'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'CONTACTPERSON', @ConstraintName = 'CK_PHONE_NUMBER_TEN_NUMBERS'

	EXEC tSQLt.ExpectNoException
	--Act
	INSERT INTO CONTACTPERSON (phonenumber) VALUES ('0123456789')
END;