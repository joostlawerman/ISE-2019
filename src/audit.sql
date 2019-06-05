

create trigger change_in___table_name__
on __table_name__
    AFTER INSERT, UPDATE, DELETE
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255);

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    -- Update
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    -- Create 
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    -- Delete
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                '__table_name__'
                select CURRENT_USER,
                @action,
                CURRENT_TIMESTAMP
            )
        END TRY
        BEGIN CATCH
            THROW
        END CATCH
    END;



select *
from INFORMATION_SCHEMA.TABLES
where TABLE_CATALOG = 'ISE_2019'
    and TABLE_SCHEMA = 'dbo'

