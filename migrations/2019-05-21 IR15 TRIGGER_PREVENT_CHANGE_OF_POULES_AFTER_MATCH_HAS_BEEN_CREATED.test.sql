-- +migrate Up
EXEC tSQLt.NewTestClass 'IR15';

-- +migrate Down
EXEC tSQLt.DropClass 'IR15';

-- +migrate Up 
CREATE PROCEDURE IR15.SetUp
AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER_OF_POULE'
        EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_INSERT'
        EXEC tSQLt.ApplyTrigger @TableName = 'TOURNAMENT_PLAYER_OF_POULE', @TriggerName = 'TRIGGER_PREVENT_CHANGE_OF_POULES_AFTER_MATCH_HAS_BEEN_CREATED_ON_UPDATE'
        EXEC tSQLt.FakeTable 'dbo', 'CHESSMATCH_OF_POULE'
        EXEC tSQLt.FakeTable 'dbo', 'POULE'

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno)
            VALUES
                ('test', 'test', 1, 1),
                ('test', 'test', 1, 2)

        INSERT INTO CHESSMATCH_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno)
            VALUES
                ('test', 'test', 1, 1),
                ('test', 'test', 1, 2)

        INSERT INTO POULE(chessclubname, tournamentname, roundnumber, pouleno)
            VALUES
                ('test', 'test', 1, 1),
                ('test', 'test', 1, 2),
                ('test', 'test', 3, 1),
                ('test', 'test', 3, 2)
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule cannot be changed when a match in that poule has started with insert]
AS
    BEGIN
        EXEC tSQLt.ExpectException @ExpectedMessage= 'A poule can not be changed when a match in that poule has started'

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno, playerid)
            VALUES
                ('test', 'test', 1, 1, 3),
                ('test', 'test', 1, 2, 4)
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in that poule not yet started with insert]
AS
    BEGIN
        DELETE FROM CHESSMATCH_OF_POULE

        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno, playerid)
            VALUES
                ('test', 'test', 1, 1, 3),
                ('test', 'test', 1, 2, 4)
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in another poule has started with insert]
AS
    BEGIN
        EXEC tSQLt.ExpectNoException

        INSERT INTO TOURNAMENT_PLAYER_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno, playerid)
            VALUES
                ('test', 'test', 3, 1, 1),
                ('test', 'test', 3, 2, 3)
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule cannot be changed when a match in that poule has started with update]
AS
    BEGIN
        EXEC tSQLt.ExpectException @ExpectedMessage= 'A poule can not be changed when a match in that poule has started'

        UPDATE TOURNAMENT_PLAYER_OF_POULE
            SET pouleno = 10
            WHERE chessclubname = 'test'
              AND tournamentname = 'test'
              AND roundnumber = 1
              AND pouleno = 1
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in that poule not yet started with update]
AS
    BEGIN
        DELETE FROM CHESSMATCH_OF_POULE
        EXEC tSQLt.ExpectNoException

        UPDATE TOURNAMENT_PLAYER_OF_POULE
            SET pouleno = 10
            WHERE chessclubname = 'test'
              AND tournamentname = 'test'
              AND roundnumber = 1
              AND pouleno = 1
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a poule can be changed when a match in another poule has started with update]
AS
    BEGIN
        EXEC tSQLt.ExpectNoException

        UPDATE TOURNAMENT_PLAYER_OF_POULE
            SET pouleno = 10
            WHERE chessclubname = 'test'
              AND tournamentname = 'test'
              AND roundnumber = 3
              AND pouleno = 1
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a tournamentname can be changed when a match in the poule has started with update]
AS
    BEGIN
        EXEC tSQLt.ExpectNoException

        UPDATE TOURNAMENT_PLAYER_OF_POULE
            SET tournamentname = 'testing'
            WHERE chessclubname = 'test'
              AND tournamentname = 'test'
    END;

-- +migrate Up
CREATE PROCEDURE [IR15].[Test if a tournamentname can be changed when no match has started with update]
AS
    BEGIN

        DELETE FROM CHESSMATCH_OF_POULE
        EXEC tSQLt.ExpectNoException

        UPDATE TOURNAMENT_PLAYER_OF_POULE
            SET tournamentname = 'testing'
            WHERE chessclubname = 'test'
              AND tournamentname = 'test'
    END;
