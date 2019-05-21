-- +migrate Up
EXEC tSQLt.NewTestClass 'IR9'
;

-- +migrate Down
EXEC tSQLt.DropClass 'IR9'
;

--+migrate Up
CREATE PROCEDURE [IR9].[test_registrationfee_greater_than_zero]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO'

	EXEC tSQLt.ExpectNoException 

	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,1.00,null,null,null,null)
END
;

--+migrate Up
CREATE PROCEDURE [IR9].[test_registrationfee_equal_to_zero]
AS
BEGIN

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO'

	EXEC tSQLt.ExpectNoException 

	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,0.00,null,null,null,null)
END
;

--+migrate Up
CREATE PROCEDURE [IR9].[test_registrationfee_lower_than_zero]
AS
BEGIN

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'

	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename = 'TOURNAMENT', @ConstraintName = 'CHK_REGISTRATION_FEE_GTE_ZERO'

	EXEC tSQLt.ExpectException 

	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values(null,null,null,null,null,null,-1.00,null,null,null,null)
END
;
