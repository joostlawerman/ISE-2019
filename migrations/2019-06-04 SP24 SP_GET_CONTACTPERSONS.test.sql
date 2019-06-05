-- +migrate Up
EXEC tSQLt.NewTestClass 'SP24';

-- +migrate Down
EXEC tSQLt.DropClass 'SP24';

-- +migrate Up
CREATE PROCEDURE SP24.SetUp AS
BEGIN
    exec tSQLt.FakeTable 'dbo.CONTACTPERSON'

    INSERT INTO CONTACTPERSON(contactname) VALUES
        ('TEST'),
        ('TEST2')
    -- Execute

END;

-- +migrate Up
CREATE PROCEDURE SP24.test_get_all_contactpersons AS
BEGIN
    SELECT contactname INTO expected FROM CONTACTPERSON

    exec tSQLt.ExpectNoException

    SELECT contactname INTO actual FROM CONTACTPERSON WHERE 1=0

    INSERT INTO actual EXEC SP_GET_CONTACTPERSONS

    EXEC tSQLt.AssertEqualsTable expected, actual
END;