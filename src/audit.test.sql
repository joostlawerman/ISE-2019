-- +migrate Up
EXEC tSQLt.NewTestClass 'audit1';

-- +migrate Down
EXEC tSQLt.DropClass 'audit1';

begin tran
	insert into CHESSCLUB values (null)
	select * from AUDITLOG


rollback tran



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSCLUB', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSCLUB'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO CHESSCLUB VALUES
        (null)

	SET @expectedAction = 'INSERT'  
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TABLE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction;
	EXEC tSQLt.assertEquals @expectedTable, @actualTable;
	EXEC tSQLt.assertEquals @expectedUser, @actualUser;
END;

-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TABLENAME'
	INSERT INTO TABLE VALUES
        (null)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TABLENAME', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM TABLE

	SET @expectedAction = 'DELETE'  
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TABLE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction;
	EXEC tSQLt.assertEquals @expectedTable, @actualTable;
	EXEC tSQLt.assertEquals @expectedUser, @actualUser;
END;

-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TABLENAME'
	INSERT INTO TABLE VALUES
        (null)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TABLENAME', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DECLARE @testColumn VARCHAR(100)
	SET @testColumn = (SELECT TOP 1 COLUMN_NAME
					   FROM INFORMATION_SCHEMA.COLUMNS
					   WHERE TABLE_NAME = 'CHESSCLUB')

	UPDATE TABLE
	SET @testColumn = null

	SET @expectedAction = 'UPDATE'  
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TABLE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction;
	EXEC tSQLt.assertEquals @expectedTable, @actualTable;
	EXEC tSQLt.assertEquals @expectedUser, @actualUser;
END;