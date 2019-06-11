select '
-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_' + TABLE_NAME  + ' 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_' + TABLE_NAME  + ' 
on ' + TABLE_NAME  + '
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = ''UPDATE''
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = ''INSERT''
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = ''DELETE''
                END
            ELSE 
                BEGIN
                    THROW 50000, ''Illigal action'', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                ''' + TABLE_NAME  + ''',
                CURRENT_USER,
                @action,
                CURRENT_TIMESTAMP
            )
        END TRY
        BEGIN CATCH
            THROW
        END CATCH
    END
;
'
from INFORMATION_SCHEMA.TABLES
where TABLE_CATALOG = 'ISE_2019'
    and TABLE_SCHEMA = 'dbo'
    and TABLE_NAME not in ('gorp_migrations', 'AUDITLOG')

