-- +migrate Up
EXEC tSQLt.NewTestClass 'SP12';

-- +migrate Down
EXEC tSQLt.DropClass 'SP12';
