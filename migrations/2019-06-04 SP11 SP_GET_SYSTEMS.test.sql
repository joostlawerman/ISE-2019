-- +migrate Up
EXEC tSQLt.NewTestClass 'SP11';

-- +migrate Down
EXEC tSQLt.DropClass 'SP11';

-- +migrate Up
CREATE PROCEDURE SP11.SetUp AS
BEGIN
    exec tSQLt.FakeTable 'dbo.SYSTEMS'

    INSERT INTO SYSTEMS(system) VALUES
        ('SYSTEM1'),
        ('SYSTEM2')

END;

-- +migrate Up
CREATE PROCEDURE SP11.test_get_all_systems AS
BEGIN

	SELECT system INTO expected FROM SYSTEMS

	CREATE TABLE actual(    
		system  VARCHAR(25)  NOT NULL
	)
	
    exec tSQLt.ExpectNoException

    INSERT INTO actual EXEC SP_GET_SYSTEMS

    EXEC tSQLt.AssertEqualsTable expected, actual
END;