-- +migrate Up
EXEC tSQLt.NewTestClass 'ir17';

-- +migrate Down
EXEC tSQLt.DropClass 'ir17';

-- +migrate Up
CREATE PROCEDURE ir17.test_sponsoramount_is_higher_than_zero AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.SPONSOR'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.SPONSOR', @ConstraintName = 'CK_SPONSOR_AMOUNT_GT_ZERO'

        EXEC tSQLt.ExpectNoException

        INSERT INTO SPONSOR (sponsoramount) VALUES (1)
    END;

-- +migrate Up
CREATE PROCEDURE ir17.test_sponsoramount_is_zero AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.SPONSOR'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.SPONSOR', @ConstraintName = 'CK_SPONSOR_AMOUNT_GT_ZERO'
        EXEC tSQLt.ExpectException

        INSERT INTO SPONSOR (sponsoramount) VALUES (0)
    END;

-- +migrate Up
CREATE PROCEDURE ir17.test_sponsoramount_is_lower_than_zero AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.SPONSOR'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.SPONSOR', @ConstraintName = 'CK_SPONSOR_AMOUNT_GT_ZERO'
        EXEC tSQLt.ExpectException

        INSERT INTO SPONSOR (sponsoramount) VALUES (-1)
    END;