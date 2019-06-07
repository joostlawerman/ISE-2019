select '
-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_' + t.TABLE_NAME  + '_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable ''dbo.' + t.TABLE_NAME  + '''
	
	EXEC tSQLt.ApplyTrigger @TableName = ''' + t.TABLE_NAME  + ''', @TriggerName = ''TRIGGER_AUDIT_CHANGE_IN_' + t.TABLE_NAME  + '''

	EXEC tSQLt.FakeTable ''dbo.AUDITLOG''

	EXEC tSQLt.ExpectNoException

	INSERT INTO ' + t.TABLE_NAME  + ' VALUES
        (' + REPLICATE('NULL,', numbers.columns - 1) + 'NULL)

	SET @expectedAction = ''INSERT''
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = ''' + t.TABLE_NAME  + '''
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_' + t.TABLE_NAME  + '_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable ''dbo.' + t.TABLE_NAME  + '''

	INSERT INTO ' + t.TABLE_NAME  + ' VALUES
        (' + REPLICATE('NULL,', numbers.columns - 1) + 'NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = ''' + t.TABLE_NAME  + ''', @TriggerName = ''TRIGGER_AUDIT_CHANGE_IN_' + t.TABLE_NAME  + '''

	EXEC tSQLt.FakeTable ''dbo.AUDITLOG''

	EXEC tSQLt.ExpectNoException

	DELETE FROM ' + t.TABLE_NAME  + '

	SET @expectedAction = ''DELETE''
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = ''' + t.TABLE_NAME  + '''
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_' + t.TABLE_NAME  + '_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable ''dbo.' + t.TABLE_NAME  + '''
	INSERT INTO ' + t.TABLE_NAME  + ' VALUES
        (' + REPLICATE('NULL,', numbers.columns - 1) + 'NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = ''' + t.TABLE_NAME  + ''', @TriggerName = ''TRIGGER_AUDIT_CHANGE_IN_' + t.TABLE_NAME  + '''

	EXEC tSQLt.FakeTable ''dbo.AUDITLOG''

	EXEC tSQLt.ExpectNoException

	UPDATE ' + t.TABLE_NAME  + '
	SET ' + c.COLUMN_NAME + ' = null

	SET @expectedAction = ''UPDATE''
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = ''' + t.TABLE_NAME  + ''' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;

'
from INFORMATION_SCHEMA.TABLES t
	cross apply (
		select top 1
			c.COLUMN_NAME
		from INFORMATION_SCHEMA.COLUMNS c
		where c.TABLE_NAME = t.TABLE_NAME
	) c
	cross apply (
		select
			COUNT(*) columns
		from INFORMATION_SCHEMA.COLUMNS c
		where c.TABLE_NAME = t.TABLE_NAME
		group by c.TABLE_NAME
	) numbers
where t.TABLE_CATALOG = 'ISE_2019'
    and t.TABLE_SCHEMA = 'dbo'
    and t.TABLE_NAME not in ('gorp_migrations', 'AUDITLOG')
group by t.TABLE_NAME, c.COLUMN_NAME, numbers.columns
