-- +migrate Up
EXEC tSQLt.NewTestClass 'SP3';

-- +migrate Down
EXEC tSQLt.DropClass 'SP3';

-- +migrate Up
CREATE PROCEDURE [SP3].[test get tournament info]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
    EXEC tSQLt.FakeTable 'dbo', 'CHESSCLUB'

    INSERT INTO CHESSCLUB(chessclubname) VALUES ('CC1')
	INSERT INTO TOURNAMENT(chessclubname, tournamentname) VALUES ('CC1', 'tourny1')

	--Act
	SELECT * INTO actual FROM TOURNAMENT WHERE 1=0

	INSERT INTO actual EXEC GET_TOURNAMENT_INFO 'tourny1', 'CC1'

	--Assert
	EXEC tSQLt.AssertEqualsTable 'TOURNAMENT', 'actual'
END;

-- +migrate Up
CREATE PROCEDURE SP3.test_error_on_get_non_existing_tournament AS
BEGIN
    exec tSQLt.FakeTable 'dbo.TOURNAMENT'
    exec tSQLt.FakeTable 'dbo.CHESSCLUB'
    INSERT INTO CHESSCLUB(chessclubname) VALUES ('test')

    exec tSQLt.ExpectException 'There is no tournament with this name'
    -- Execute
    EXEC GET_TOURNAMENT_INFO 'Test', 'test'
END;

-- +migrate Up
CREATE PROCEDURE SP3.test_error_on_get_non_existing_chessclubname AS
BEGIN
    exec tSQLt.FakeTable 'dbo.TOURNAMENT'
    exec tSQLt.FakeTable 'dbo.CHESSCLUB'

    exec tSQLt.ExpectException 'There is no chessclub with this name'
    -- Execute
    EXEC GET_TOURNAMENT_INFO 'Test', 'test'

END;