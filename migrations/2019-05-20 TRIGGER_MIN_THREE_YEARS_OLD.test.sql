EXEC tSQLt.NewTestClass 'IR5';
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
--test 1
--

CREATE OR ALTER PROCEDURE [IR5].[test participant is 1 year old]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER';

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_PLAYER', @triggername = 'TRIGGER_MIN_THREE_YEARS_OLD'

	INSERT INTO PLAYER (playerid, birthdate) VALUES (1, '2018-05-20')
	INSERT INTO TOURNAMENT (tournamentname, chessclubname, starts) VALUES ('tourny1', 'CC1', '2019-05-20')

	EXEC tSQLt.ExpectException @ExpectedMessage = 'A participant has to be 3 years old when te tournament starts.', @ExpectedSeverity = 16, @ExpectedErrorNumber = 50005
	--Act
	INSERT INTO TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid) VALUES ('CC1', 'tourny1', 1)
END
GO

EXEC [tSQLt].[Run] 'IR5.test participant is 1 years old'

--
--test 2
--

CREATE OR ALTER PROCEDURE [IR5].[test participant is 5 years old]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER';

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_PLAYER', @triggername = 'TRIGGER_MIN_THREE_YEARS_OLD'

	INSERT INTO PLAYER (playerid, birthdate) VALUES (1, '2014-05-20')
	INSERT INTO TOURNAMENT (tournamentname, chessclubname, starts) VALUES ('tourny1', 'CC1', '2019-05-20')

	EXEC tSQLt.ExpectNoException
	--Act
	INSERT INTO TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid) VALUES ('CC1', 'tourny1', 1)
END
GO

EXEC [tSQLt].[Run] 'IR5.test participant is 5 years old'

--
--test 3
--

CREATE OR ALTER PROCEDURE [IR5].[test participant is 3 years old]
AS
BEGIN
	--Assemble
	EXEC tSQLt.FakeTable 'dbo', 'PLAYER';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT';
	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT_PLAYER';

	EXEC [tSQLt].[ApplyTrigger] @tablename = 'dbo.TOURNAMENT_PLAYER', @triggername = 'TRIGGER_MIN_THREE_YEARS_OLD'

	INSERT INTO PLAYER (playerid, birthdate) VALUES (1, '2016-05-20')
	INSERT INTO TOURNAMENT (tournamentname, chessclubname, starts) VALUES ('tourny1', 'CC1', '2019-05-20')

	EXEC tSQLt.ExpectNoException
	--Act
	INSERT INTO TOURNAMENT_PLAYER (chessclubname, tournamentname, playerid) VALUES ('CC1', 'tourny1', 1)
END
GO

EXEC [tSQLt].[Run] 'IR5.test participant is 3 years old'