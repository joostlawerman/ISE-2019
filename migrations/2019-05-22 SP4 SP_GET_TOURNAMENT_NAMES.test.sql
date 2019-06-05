-- +migrate Up
EXEC tSQLt.NewTestClass 'SP4';

-- +migrate Down
EXEC tSQLt.DropClass 'SP4';

-- +migrate Up
CREATE PROCEDURE [SP4].[Test get all tournament names]
AS
    BEGIN
        --Arrange
        EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
        INSERT INTO TOURNAMENT
        VALUES ('test', 'eerste tournooi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
            ('test', 'tweede tournooi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

        --Act
        CREATE TABLE actual (
            chessclubname        VARCHAR(100) NULL,
            tournamentname       VARCHAR(100) NULL,
            winner               INT          NULL,
            contactname          VARCHAR(101) NULL,
            starts               DATETIME     NULL,
            ends                 DATETIME     NULL,
            registrationfee      MONEY        NULL,
            addressline1         VARCHAR(100) NULL,
            postalcode           VARCHAR(6)   NULL,
            city                 CHAR(100)    NULL,
            registrationdeadline DATETIME     NULL,
        )

        INSERT INTO actual (chessclubname, tournamentname) EXEC SP_GET_TOURNAMENT_NAMES @chessclubname = NULL

        --Assert
        EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'actual'

    END;

-- +migrate Up
CREATE PROCEDURE [SP4].[Test get all tournament names of chessclub] AS
    BEGIN
        EXEC tSQLt.FakeTable 'dbo.TOURNAMENT'
        EXEC tSQLt.FakeTable 'dbo.CHESSCLUB'
        INSERT INTO CHESSCLUB (chessclubname) VALUES ('test')
        -- Execute
        INSERT INTO TOURNAMENT (chessclubname, tournamentname)
        VALUES ('test', 'eerste tournooi'),
            ('test', 'tweede tournooi'),
            ('tested', 'tweede tournooi')

        SELECT * INTO actual FROM TOURNAMENT WHERE 1 = 0
        SELECT * INTO expected FROM TOURNAMENT WHERE 1 = 0

        INSERT INTO expected (chessclubname, tournamentname) VALUES
            ('test', 'eerste tournooi'),
            ('test', 'tweede tournooi')

        INSERT INTO actual (chessclubname, tournamentname) EXEC SP_GET_TOURNAMENT_NAMES @chessclubname = 'test'

        EXEC tSQLt.AssertEqualsTable 'expected', 'actual'

    END;