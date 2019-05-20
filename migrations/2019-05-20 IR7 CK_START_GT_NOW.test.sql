-- +migrate Up 
EXEC tSQLt.NewTestClass 'ir7';

-- +migrate Down
EXEC tSQLt.DropClass 'ir7';

-- +migrate Up 
CREATE OR ALTER PROCEDURE ir7.test_date_is_greater_than_now AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @SchemaName = 'dbo', @Tablename = 'TOURNAMENT',
                                   @ConstraintName = 'CK_START_GT_NOW'
        
        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT (
            [chessclubname], 
            [tournamentname], 
            [winner], 
            [contactname], 
            [starts], 
            [ends], 
            [registrationfee], 
            [addressline1], 
            [postalcode], 
            [city], 
            [registrationdeadline]
        ) VALUES (
            null, 
            null, 
            null, 
            null, 
            DATEADD(year, 1, getdate()), 
            null, 
            null, 
            null, 
            null, 
            null, 
            null
        )
    END
;

-- +migrate Up 
CREATE OR ALTER PROCEDURE [ir7].test_date_is_before_now AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @SchemaName = 'dbo', @Tablename = 'TOURNAMENT',
                                   @ConstraintName = 'CK_START_GT_NOW'

        EXEC tSQLt.ExpectException

        --actie
        INSERT INTO TOURNAMENT (
            [chessclubname], 
            [tournamentname], 
            [winner], 
            [contactname], 
            [starts], 
            [ends], 
            [registrationfee], 
            [addressline1], 
            [postalcode], 
            [city], 
            [registrationdeadline]
        ) VALUES (
            null, 
            null, 
            null, 
            null, 
            DATEADD(year, -1, getdate()), 
            null, 
            null, 
            null, 
            null, 
            null, 
            null
        )
    END
;

