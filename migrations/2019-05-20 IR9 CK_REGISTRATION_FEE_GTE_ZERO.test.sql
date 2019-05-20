-- +migrate Up
EXEC tSQLt.NewTestClass 'testIR9';
GO
;

-- +migrate Down
EXEC tSQLt.DropClass 'testIR9';
GO
;

--+migrate Up
CREATE or ALTER PROCEDURE [testIR9].[test_registrationfee_greater_than_zero]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO';

	--Assert
	EXEC tSQLt.ExpectNoException 

	--Act
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,1.00,null,null,null,null);
END
GO
;

--+migrate Up
CREATE or ALTER PROCEDURE [testIR9].[test_registrationfee_equal_to_zero]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO';

	--Assert
	EXEC tSQLt.ExpectNoException 

	--Act
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,0.00,null,null,null,null);
END
GO
;

--+migrate Up
CREATE or ALTER PROCEDURE [testIR9].[test_registrationfee_lower_than_zero]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO';

	--Assert
	EXEC tSQLt.ExpectException 

	--Act
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,-1.00,null,null,null,null);
END
GO
;
