-- +migrate Up
EXEC tSQLt.NewTestClass 'SP23';

-- +migrate Down
EXEC tSQLt.DropClass 'SP23';

-- +migrate Up
CREATE PROCEDURE SP23.SetUp AS
BEGIN
    exec tSQLt.FakeTable 'dbo.CHESSCLUB'

    INSERT INTO CHESSCLUB(chessclubname) VALUES
        ('TEST'),
        ('TEST2')
    -- Execute

END;

-- +migrate Up
CREATE PROCEDURE SP23.test_get_all_chessclubs AS
BEGIN
    SELECT chessclubname INTO expected FROM CHESSCLUB

    exec tSQLt.ExpectNoException

    SELECT chessclubname INTO actual FROM CHESSCLUB WHERE 1=0

    INSERT INTO actual EXEC SP_GET_CHESSCLUBS

    EXEC tSQLt.AssertEqualsTable expected, actual
END;