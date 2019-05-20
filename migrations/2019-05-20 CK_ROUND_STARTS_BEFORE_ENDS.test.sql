-- +migrate up
EXEC tSQLt.NewTestClass 'IR13';

-- +migrate down
EXEC tSQLt.DropClass 'IR13';

--
--test 1
--

-- +migrate up
CREATE OR ALTER PROCEDURE [IR13].[test start is before end]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT_ROUND', @ConstraintName = 'CK_ROUND_STARTS_BEFORE_ENDS';

	EXEC tSQLt.ExpectException
	--Act
	INSERT INTO TOURNAMENT_ROUND (starts, ends) VALUES ('2019-05-20', '2019-05-19')
END;

--
--test 2
--

-- +migrate up
CREATE OR ALTER PROCEDURE [IR13].[test start is after end]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT_ROUND', @ConstraintName = 'CK_ROUND_STARTS_BEFORE_ENDS';

	EXEC tSQLt.ExpectNoException
	--Act
	INSERT INTO TOURNAMENT_ROUND (starts, ends) VALUES ('2019-05-20', '2019-05-25')
END;

--
--test 3
--

-- +migrate up
CREATE OR ALTER PROCEDURE [IR13].[test start is same time end]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT_ROUND', @ConstraintName = 'CK_ROUND_STARTS_BEFORE_ENDS';

	EXEC tSQLt.ExpectException
	--Act
	INSERT INTO TOURNAMENT_ROUND (starts, ends) VALUES ('2019-05-20', '2019-05-20')
END;