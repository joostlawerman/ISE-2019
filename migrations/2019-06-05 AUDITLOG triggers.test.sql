-- +migrate Up
EXEC tSQLt.NewTestClass 'audit1';

-- +migrate Down
EXEC tSQLt.DropClass 'audit1';




-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_CHESSCLUB_in_AUDIT] AS
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
        (NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSCLUB'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_CHESSCLUB_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'

	INSERT INTO CHESSCLUB VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSCLUB', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSCLUB'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM CHESSCLUB

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSCLUB'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_CHESSCLUB_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
	INSERT INTO CHESSCLUB VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSCLUB', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSCLUB'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE CHESSCLUB
	SET addressline1 = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSCLUB' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.PLAYER'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO PLAYER VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'PLAYER'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.PLAYER'

	INSERT INTO PLAYER VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM PLAYER

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'PLAYER'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.PLAYER'
	INSERT INTO PLAYER VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE PLAYER
	SET addressline1 = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'PLAYER' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_CONTACTPERSON_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CONTACTPERSON', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CONTACTPERSON'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO CONTACTPERSON VALUES
        (NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CONTACTPERSON'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_CONTACTPERSON_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'

	INSERT INTO CONTACTPERSON VALUES
        (NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CONTACTPERSON', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CONTACTPERSON'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM CONTACTPERSON

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CONTACTPERSON'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_CONTACTPERSON_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
	INSERT INTO CONTACTPERSON VALUES
        (NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CONTACTPERSON', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CONTACTPERSON'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE CONTACTPERSON
	SET contactname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CONTACTPERSON' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_TOURNAMENT_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO TOURNAMENT VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_TOURNAMENT_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'

	INSERT INTO TOURNAMENT VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM TOURNAMENT

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_TOURNAMENT_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
	INSERT INTO TOURNAMENT VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE TOURNAMENT
	SET addressline1 = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_SYSTEMS_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SYSTEMS'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SYSTEMS', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SYSTEMS'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO SYSTEMS VALUES
        (NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SYSTEMS'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_SYSTEMS_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SYSTEMS'

	INSERT INTO SYSTEMS VALUES
        (NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SYSTEMS', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SYSTEMS'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM SYSTEMS

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SYSTEMS'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_SYSTEMS_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SYSTEMS'
	INSERT INTO SYSTEMS VALUES
        (NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SYSTEMS', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SYSTEMS'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE SYSTEMS
	SET system = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SYSTEMS' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_TOURNAMENT_ROUND_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_ROUND', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_ROUND'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO TOURNAMENT_ROUND VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_ROUND'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_TOURNAMENT_ROUND_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'

	INSERT INTO TOURNAMENT_ROUND VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_ROUND', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_ROUND'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM TOURNAMENT_ROUND

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_ROUND'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_TOURNAMENT_ROUND_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'
	INSERT INTO TOURNAMENT_ROUND VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_ROUND', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_ROUND'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE TOURNAMENT_ROUND
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_ROUND' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.POULE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO POULE VALUES
        (NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.POULE'

	INSERT INTO POULE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM POULE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.POULE'
	INSERT INTO POULE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE POULE
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'POULE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_TOURNAMENT_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO TOURNAMENT_PLAYER VALUES
        (NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_TOURNAMENT_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER'

	INSERT INTO TOURNAMENT_PLAYER VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM TOURNAMENT_PLAYER

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_TOURNAMENT_PLAYER_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER'
	INSERT INTO TOURNAMENT_PLAYER VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE TOURNAMENT_PLAYER
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_TOURNAMENT_PLAYER_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER_OF_POULE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO TOURNAMENT_PLAYER_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER_OF_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_TOURNAMENT_PLAYER_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER_OF_POULE'

	INSERT INTO TOURNAMENT_PLAYER_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM TOURNAMENT_PLAYER_OF_POULE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER_OF_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_TOURNAMENT_PLAYER_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_PLAYER_OF_POULE'
	INSERT INTO TOURNAMENT_PLAYER_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE TOURNAMENT_PLAYER_OF_POULE
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'TOURNAMENT_PLAYER_OF_POULE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_CHESSMATCH_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCH_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCH_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO CHESSMATCH_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCH_OF_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_CHESSMATCH_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'

	INSERT INTO CHESSMATCH_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCH_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCH_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM CHESSMATCH_OF_POULE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCH_OF_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_CHESSMATCH_OF_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
	INSERT INTO CHESSMATCH_OF_POULE VALUES
        (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCH_OF_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCH_OF_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE CHESSMATCH_OF_POULE
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCH_OF_POULE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_ROUND_ROBIN_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROUND_ROBIN_POULE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROUND_ROBIN_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROUND_ROBIN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO ROUND_ROBIN_POULE VALUES
        (NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROUND_ROBIN_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_ROUND_ROBIN_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROUND_ROBIN_POULE'

	INSERT INTO ROUND_ROBIN_POULE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROUND_ROBIN_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROUND_ROBIN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM ROUND_ROBIN_POULE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROUND_ROBIN_POULE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_ROUND_ROBIN_POULE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROUND_ROBIN_POULE'
	INSERT INTO ROUND_ROBIN_POULE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROUND_ROBIN_POULE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROUND_ROBIN_POULE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE ROUND_ROBIN_POULE
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROUND_ROBIN_POULE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_CHESSMATCHMOVE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCHMOVE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCHMOVE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCHMOVE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO CHESSMATCHMOVE VALUES
        (NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCHMOVE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_CHESSMATCHMOVE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCHMOVE'

	INSERT INTO CHESSMATCHMOVE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCHMOVE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCHMOVE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM CHESSMATCHMOVE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCHMOVE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_CHESSMATCHMOVE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.CHESSMATCHMOVE'
	INSERT INTO CHESSMATCHMOVE VALUES
        (NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'CHESSMATCHMOVE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_CHESSMATCHMOVE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE CHESSMATCHMOVE
	SET colour = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'CHESSMATCHMOVE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_SPONSOR_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SPONSOR'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SPONSOR', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SPONSOR'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO SPONSOR VALUES
        (NULL,NULL,NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SPONSOR'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_SPONSOR_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SPONSOR'

	INSERT INTO SPONSOR VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SPONSOR', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SPONSOR'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM SPONSOR

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SPONSOR'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_SPONSOR_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.SPONSOR'
	INSERT INTO SPONSOR VALUES
        (NULL,NULL,NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'SPONSOR', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_SPONSOR'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE SPONSOR
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'SPONSOR' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_INSERT_ROLE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROLE'
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROLE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROLE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	INSERT INTO ROLE VALUES
        (NULL,NULL,NULL)

	SET @expectedAction = 'INSERT'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROLE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;



-- +migrate Up
CREATE PROCEDURE [audit1].[test_DELETE_ROLE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROLE'

	INSERT INTO ROLE VALUES
        (NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROLE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROLE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	DELETE FROM ROLE

	SET @expectedAction = 'DELETE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROLE'
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


-- +migrate Up
CREATE PROCEDURE [audit1].[test_UPDATE_ROLE_in_AUDIT] AS
BEGIN
	DECLARE @expectedAction VARCHAR(14) 
    DECLARE @actualAction VARCHAR(14)
	DECLARE @expectedTable VARCHAR(26)
	DECLARE @actualTable VARCHAR(26)
	DECLARE @expectedUser VARCHAR(25)
	DECLARE @actualUser VARCHAR(25)

	EXEC tSQLt.FakeTable 'dbo.ROLE'
	INSERT INTO ROLE VALUES
        (NULL,NULL,NULL)
	
	EXEC tSQLt.ApplyTrigger @TableName = 'ROLE', @TriggerName = 'TRIGGER_AUDIT_CHANGE_IN_ROLE'

	EXEC tSQLt.FakeTable 'dbo.AUDITLOG'

	EXEC tSQLt.ExpectNoException

	UPDATE ROLE
	SET chessclubname = null

	SET @expectedAction = 'UPDATE'
	SET @actualAction = (SELECT [action] from AUDITLOG)
	SET @expectedTable = 'ROLE' 
	SET @actualTable = (SELECT [tablename] from AUDITLOG) 
	SET @expectedUser = CURRENT_USER
	SET @actualUser = (SELECT [user] from AUDITLOG)

	EXEC tSQLt.assertEquals @expectedAction, @actualAction
	EXEC tSQLt.assertEquals @expectedTable, @actualTable
	EXEC tSQLt.assertEquals @expectedUser, @actualUser
END
;


