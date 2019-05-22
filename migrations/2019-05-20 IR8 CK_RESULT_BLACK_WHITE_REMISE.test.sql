-- +migrate Up
EXEC tSQLt.NewTestClass 'IR8';

-- +migrate Down
EXEC tSQLt.DropClass 'IR8';

-- +migrate Up
CREATE PROCEDURE IR8.test_CHESSMATCH_OF_POULE_result_is_black AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH_OF_POULE', @ConstraintName = 'CK_RESULT_BLACK_WHITE_REMISE'
        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSMATCH_OF_POULE (result) VALUES ('black')
    END;

-- +migrate Up
CREATE PROCEDURE IR8.test_CHESSMATCH_OF_POULE_result_is_white AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH_OF_POULE', @ConstraintName = 'CK_RESULT_BLACK_WHITE_REMISE'
        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSMATCH_OF_POULE (result) VALUES ('white')
    END;

-- +migrate Up
CREATE PROCEDURE IR8.test_CHESSMATCH_OF_POULE_result_is_remise AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH_OF_POULE', @ConstraintName = 'CK_RESULT_BLACK_WHITE_REMISE'
        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSMATCH_OF_POULE (result) VALUES ('remise')
    END;

-- +migrate Up
CREATE PROCEDURE IR8.test_CHESSMATCH_OF_POULE_has_no_results AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH_OF_POULE', @ConstraintName = 'CK_RESULT_BLACK_WHITE_REMISE'
        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSMATCH_OF_POULE (result) VALUES (null)
    END;

-- +migrate Up
CREATE PROCEDURE IR8.test_CHESSMATCH_OF_POULE_result_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH_OF_POULE', @ConstraintName = 'CK_RESULT_BLACK_WHITE_REMISE'
        EXEC tSQLt.ExpectException

        INSERT INTO CHESSMATCH_OF_POULE (result) VALUES ('yellow')
    END;

