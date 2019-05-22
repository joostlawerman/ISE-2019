-- +migrate Up
EXEC tSQLt.NewTestClass 'ir3';

-- +migrate Down
EXEC tSQLt.DropClass 'ir3';

-- +migrate Up
CREATE PROCEDURE ir3.test_tournament_postal_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.TOURNAMENT', @ConstraintName = 'CK_TOURNAMENT_POSTCODE_VALID'

        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT (postalcode) VALUES 
            ('7420CN'),
            ('6420AN'),
            ('3420SN'),
            ('8320CF'),
            ('1000AS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_chessclub_postal_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'CK_CHESSCLUB_POSTCODE_VALID'

        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSCLUB (postalcode) VALUES 
            ('7420CN'),
            ('6420AN'),
            ('3420SN'),
            ('8320CF'),
            ('1000AS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_player_postal_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'CK_PLAYER_POSTCODE_VALID'

        EXEC tSQLt.ExpectNoException

        INSERT INTO PLAYER (postalcode) VALUES 
            ('7420CN'),
            ('6420AN'),
            ('3420SN'),
            ('8320CF'),
            ('1000AS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_tournament_postal_is_lower_than_1000 AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.TOURNAMENT', @ConstraintName = 'CK_TOURNAMENT_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO TOURNAMENT (postalcode) VALUES ('0032CN')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_chessclub_postal_is_lower_than_1000 AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'CK_CHESSCLUB_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (postalcode) VALUES ('0032CN')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_player_postal_is_lower_than_1000 AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'CK_PLAYER_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (postalcode) VALUES ('0032CN')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_tournament_postal_contains_illegal_caracters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.TOURNAMENT', @ConstraintName = 'CK_TOURNAMENT_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO TOURNAMENT (postalcode) VALUES ('2030SS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_chessclub_postal_contains_illegal_caracters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'CK_CHESSCLUB_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (postalcode) VALUES ('2030SS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_player_postal_contains_illegal_caracters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'CK_PLAYER_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (postalcode) VALUES ('2030SS')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_tournament_postal_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.TOURNAMENT', @ConstraintName = 'CK_TOURNAMENT_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO TOURNAMENT (postalcode) VALUES ('23X33A')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_chessclub_postal_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'CK_CHESSCLUB_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (postalcode) VALUES ('23X33A')
    END;

-- +migrate Up
CREATE PROCEDURE ir3.test_player_postal_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'CK_PLAYER_POSTCODE_VALID'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (postalcode) VALUES ('23X33A')
    END;
