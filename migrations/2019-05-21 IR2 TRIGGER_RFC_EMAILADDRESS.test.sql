-- +migrate Up
EXEC tSQLt.NewTestClass 'ir2';

-- +migrate Down
EXEC tSQLt.DropClass 'ir2';

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectNoException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('simple@example.com'),
            ('very.common@example.com'),
            ('disposable.style.email.with+symbol@example.com'),
            ('other.email-with-hyphen@example.com'),
            ('fully-qualified-domain@example.com'),
            ('user.name+tag+sorting@example.co'),
            ('x@example.com'),
            ('example-indeed@strange-example.com'),
            ('example@s.example')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectNoException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('simple@example.com'),
            ('very.common@example.com'),
            ('disposable.style.email.with+symbol@example.com'),
            ('other.email-with-hyphen@example.com'),
            ('fully-qualified-domain@example.com'),
            ('user.name+tag+sorting@example.co'),
            ('x@example.com'),
            ('example-indeed@strange-example.com'),
            ('example@s.example')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_is_correct AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectNoException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('simple@example.com'),
            ('very.common@example.com'),
            ('disposable.style.email.with+symbol@example.com'),
            ('other.email-with-hyphen@example.com'),
            ('fully-qualified-domain@example.com'),
            ('user.name+tag+sorting@example.co'),
            ('x@example.com'),
            ('example-indeed@strange-example.com'),
            ('example@s.example')
    END;


-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_misses_at_sign AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('Abc.example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_has_multiple_at_signs AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('A@b@c@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_illigal_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('a"b(c)d,e:f;g<h>i[j\k]l@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_badly_qouted AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('just"not"right@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_backward_slash AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('this is"not\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_multiple_backward_slashes AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
            ('this\ still\"not\\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_local_part_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
        ('1234567890123456789012345678901234567890123456789012345678901234+x@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_local_part_is_longer_than_64_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
        ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_player_emailaddress_string_is_empty AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.PLAYER'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.PLAYER', @ConstraintName = 'TRIGGER_PLAYER_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO PLAYER (emailaddress) VALUES 
        ('')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_misses_at_sign AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('Abc.example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_has_multiple_at_signs AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('A@b@c@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_illigal_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('a"b(c)d,e:f;g<h>i[j\k]l@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_badly_qouted AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('just"not"right@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_backward_slash AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('this is"not\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_multiple_backward_slashes AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
            ('this\ still\"not\\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_local_part_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
        ('1234567890123456789012345678901234567890123456789012345678901234+x@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_local_part_is_longer_than_64_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
        ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_chessclub_emailaddress_string_is_empty AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CHESSCLUB', @ConstraintName = 'TRIGGER_CHESSCLUB_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CHESSCLUB (emailaddress) VALUES 
        ('')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_misses_at_sign AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('Abc.example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_has_multiple_at_signs AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('A@b@c@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_illigal_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('a"b(c)d,e:f;g<h>i[j\k]l@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_badly_qouted AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('just"not"right@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_backward_slash AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('this is"not\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_multiple_backward_slashes AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
            ('this\ still\"not\\allowed@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_local_part_is_incorrect AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
        ('1234567890123456789012345678901234567890123456789012345678901234+x@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_local_part_is_longer_than_64_characters AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
        ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com')
    END;

-- +migrate Up
CREATE PROCEDURE ir2.test_contactperson_emailaddress_string_is_empty AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.CONTACTPERSON'
        EXEC tSQLt.ApplyConstraint @Tablename = 'dbo.CONTACTPERSON', @ConstraintName = 'TRIGGER_CONTACTPERSON_RFC_EMAILADDRESS'

        EXEC tSQLt.ExpectException

        INSERT INTO CONTACTPERSON (emailaddress) VALUES 
        ('')
    END;
