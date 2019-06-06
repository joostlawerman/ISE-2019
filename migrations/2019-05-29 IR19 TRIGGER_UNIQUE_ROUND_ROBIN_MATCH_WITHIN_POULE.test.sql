-- +migrate Up
EXEC tSQLt.NewTestClass 'IR19';

-- +migrate Down
EXEC tSQLt.DropClass 'IR19';

-- +migrate Up
CREATE PROCEDURE IR19.test_insert_succeed AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
    EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'

    INSERT INTO TOURNAMENT_ROUND(chessclubname, tournamentname, roundnumber, system) VALUES
        ('test', 'round', 1, 'round robin'),
        ('test', 'brak', 1, 'bracket')

    INSERT INTO CHESSMATCH_OF_POULE(matchno,chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
        (1,'test', 'round', 1, 1, 1, 2),
        (2,'test', 'round', 1, 1, 3, 4),
        (3,'test', 'brak', 1, 1, 3, 4)

    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH_OF_POULE',
                                @triggername = 'TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE'

	select * from CHESSMATCH_OF_POULE
    EXEC tSQLt.ExpectNoException
    -- Execute
    INSERT INTO CHESSMATCH_OF_POULE (matchno,chessclubname,tournamentname,roundnumber,pouleno,playeridwhite,playeridblack,result) 
	VALUES (4,'test','round',1,1,1,3,null)
            
END;

exec tsqlt.run 'IR19'


-- +migrate Up
CREATE PROCEDURE IR19.test_duplicate_inserted_values AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
    EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'

    INSERT INTO TOURNAMENT_ROUND(chessclubname, tournamentname, roundnumber, system) VALUES
        ('test', 'round', 1, 'round robin'),
        ('test', 'brak', 1, 'bracket')

    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH_OF_POULE',
                                @triggername = 'TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE'


    EXEC tSQLt.ExpectException 'There is a match that is duplicate in a round robin poule'
    -- Execute
    INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'round', 1, 1, 2, 1), ('test', 'round', 1, 1, 2, 1)
END;










-- +migrate Up
CREATE PROCEDURE IR19.test_existing_match_inverted_in_round_robin_poule_error AS
BEGIN
	EXEC tSQLt.FakeTable 'dbo.CHESSMATCH_OF_POULE'
    EXEC tSQLt.FakeTable 'dbo.TOURNAMENT_ROUND'

    INSERT INTO TOURNAMENT_ROUND(chessclubname, tournamentname, roundnumber, system) VALUES
        ('test', 'round', 1, 'round robin'),
        ('test', 'brak', 1, 'bracket')

    INSERT INTO CHESSMATCH_OF_POULE(chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
        ('test', 'round', 1, 1, 1, 2),
        ('test', 'round', 1, 1, 3, 4),
        ('test', 'brak', 1, 1, 3, 4)

    EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.CHESSMATCH_OF_POULE',
                                @triggername = 'TRIGGER_UNIQUE_ROUND_ROBIN_MATCH_WITHIN_POULE'


    EXEC tSQLt.ExpectException 'There is a match that is duplicate in a round robin poule'
    -- Execute
    INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'round', 1, 1, 2, 1)
END;

-- +migrate Up
CREATE PROCEDURE IR19.test_duplicate_match_in_round_robin_poule AS
BEGIN

    EXEC tSQLt.ExpectException 'There is a match that is duplicate in a round robin poule'
    -- Execute

    INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'round', 1, 1, 1, 2)
END;

-- +migrate Up
CREATE PROCEDURE IR19.test_bracket_doesnt_trigger_existing_match_inverted AS
BEGIN

    EXEC tSQLt.ExpectNoException
    -- Execute

    INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'brak', 1, 1, 4, 3)
END;

-- +migrate Up
CREATE PROCEDURE IR19.test_bracket_doesnt_trigger_existing_match_duplicate AS
BEGIN

    EXEC tSQLt.ExpectNoException
    -- Execute

    INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'brak', 1, 1, 3, 4)
END;

-- +migrate Up
CREATE PROCEDURE IR19.test_successfully_insert_unique_round_robin_match AS
BEGIN
    exec tSQLt.ExpectNoException
    -- Execute
        INSERT INTO CHESSMATCH_OF_POULE (chessclubname, tournamentname, roundnumber, pouleno, playeridwhite, playeridblack) VALUES
            ('test', 'round', 1, 1, 1, 4)
END;