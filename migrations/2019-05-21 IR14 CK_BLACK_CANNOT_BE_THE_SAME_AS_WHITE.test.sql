-- +migrate Up
EXEC tSQLt.NewTestClass 'IR14';

-- +migrate Down
EXEC tSQLt.DropClass 'IR14';

-- +migrate Up
CREATE PROCEDURE IR14.test_black_player_is_same_as_white_player AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH',
                                   @ConstraintName = 'CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE'
        EXEC tSQLt.ExpectException
        -- Execute
        INSERT INTO CHESSMATCH (playeridblack, playeridwhite) VALUES (1, 1)

    END;

-- +migrate Up
CREATE PROCEDURE IR14.test_black_player_is_not_same_as_white_player AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSMATCH'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSMATCH',
                                   @ConstraintName = 'CK_BLACK_CANNOT_BE_THE_SAME_AS_WHITE'
        EXEC tSQLt.ExpectNoException
        -- Execute
        INSERT INTO CHESSMATCH (playeridblack, playeridwhite) VALUES (1, 2)

    END;