-- +migrate Up
EXEC tSQLt.NewTestClass 'IR11'
;

-- +migrate Down
EXEC tSQLt.DropClass 'IR11'
;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_before_tournament_end]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND', @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values('test','testen',null,null,null,'2019-05-21 10:00:00',NULL,null,null,null,null)

	EXEC tSQLt.ExpectNoException 

	insert into 
	TOURNAMENT_ROUND(chessclubname,tournamentname,roundnumber,system,starts,ends)
	values('test','testen',null,null,null, '2008-11-11 13:23:44')
END
;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_on_tournament_end]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND', @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values('test','testen',null,null,null,'2019-05-21 10:00:00',NULL,null,null,null,null)

	EXEC tSQLt.ExpectNoException 

	insert into 
	TOURNAMENT_ROUND(chessclubname,tournamentname,roundnumber,system,starts,ends)
	values('test','testen',null,null,null, '2019-05-21 10:00:00')
END
;

-- +migrate Up
CREATE PROCEDURE [IR11].[test_end_after_tournament_end]
AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_ROUND'
	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_ROUND', @triggername = 'TRIGGER_ROUND_END_BEFORE_TOURNAMENT_END'

	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
	insert into 
	TOURNAMENT(chessclubname,tournamentname,winner,contactname,starts,ends,registrationfee,addressline1,postalcode,city,registrationdeadline)
	values('test','testen',null,null,null,'2019-05-21 10:00:00',NULL,null,null,null,null)

	EXEC tSQLt.ExpectException 

	insert into 
	TOURNAMENT_ROUND(chessclubname,tournamentname,roundnumber,system,starts,ends)
	values('test','testen',null,null,null, '2019-05-21 10:20:00')
END
;

exec tsqlt.run 'IR11'

