
-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSCLUB 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSCLUB 
on CHESSCLUB
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'CHESSCLUB',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_PLAYER 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_PLAYER 
on PLAYER
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'PLAYER',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_CONTACTPERSON 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_CONTACTPERSON 
on CONTACTPERSON
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'CONTACTPERSON',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT 
on TOURNAMENT
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'TOURNAMENT',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_SYSTEMS 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_SYSTEMS 
on SYSTEMS
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'SYSTEMS',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_ROUND 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_ROUND 
on TOURNAMENT_ROUND
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'TOURNAMENT_ROUND',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_POULE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_POULE 
on POULE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'POULE',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER 
on TOURNAMENT_PLAYER
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'TOURNAMENT_PLAYER',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER_OF_POULE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_TOURNAMENT_PLAYER_OF_POULE 
on TOURNAMENT_PLAYER_OF_POULE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'TOURNAMENT_PLAYER_OF_POULE',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSMATCH_OF_POULE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSMATCH_OF_POULE 
on CHESSMATCH_OF_POULE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'CHESSMATCH_OF_POULE',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_ROUND_ROBIN_POULE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_ROUND_ROBIN_POULE 
on ROUND_ROBIN_POULE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'ROUND_ROBIN_POULE',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSMATCHMOVE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_CHESSMATCHMOVE 
on CHESSMATCHMOVE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'CHESSMATCHMOVE',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_SPONSOR 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_SPONSOR 
on SPONSOR
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'SPONSOR',
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


-- +migrate Down
DROP TRIGGER TRIGGER_AUDIT_CHANGE_IN_ROLE 
;

-- +migrate Up
create TRIGGER TRIGGER_AUDIT_CHANGE_IN_ROLE 
on ROLE
    AFTER INSERT, UPDATE, DELETE 
AS
    BEGIN
        IF @@ROWCOUNT = 0
            RETURN
        BEGIN TRY
            DECLARE @action VARCHAR(255)

            IF EXISTS (SELECT * FROM DELETED) AND EXISTS  (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'UPDATE'
                END
            ELSE IF EXISTS (SELECT * FROM INSERTED)
                BEGIN
                    SET @action = 'INSERT'
                END
            ELSE IF EXISTS (SELECT * FROM DELETED)
                BEGIN
                    SET @action = 'DELETE'
                END
            ELSE 
                BEGIN
                    THROW 50000, 'Illigal action', 1
                END

            INSERT INTO AUDITLOG (
                tablename,
	            [user],
	            [action],
            	[timestamp]
            ) VALUES (
                'ROLE',
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

