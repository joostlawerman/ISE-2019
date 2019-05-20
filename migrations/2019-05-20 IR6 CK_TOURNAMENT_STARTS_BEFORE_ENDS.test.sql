-- +migrate Up
EXEC tSQLt.NewTestClass 'IR6';

-- +migrate Down
EXEC tSQLt.DropClass 'IR6';

-- +migrate Up
CREATE PROCEDURE IR6.SetUp
AS
BEGIN
   	--Arrange
   	EXEC tSQLt.FakeTable 'dbo', 'TOURNAMENT'
   	EXEC tSQLt.ApplyConstraint @SchemaName= 'dbo', @Tablename= 'TOURNAMENT', @ConstraintName = 'CK_TOURNAMENT_STARTS_BEFORE_ENDS'
END;

-- +migrate Up
CREATE PROCEDURE [IR6].[test starts before ends]
AS
BEGIN
   	--Assert
   	EXEC tSQLt.ExpectNoException

	--Act
    INSERT INTO TOURNAMENT 
    VALUES   ('Schaakverening Horst', 'Toernooi 2018 Horst', 2, 'Gert','2018-06-05 11:30:34', 
			  '2018-06-05 15:40:05', 10, 'Appellaan 2', '6738TE', 'Arnhem', '2018-05-04 10:15:32')
END;

-- +migrate Up
CREATE PROCEDURE [IR6].[test starts after ends]
AS
BEGIN
   	--Assert
   	EXEC tSQLt.ExpectException
 
   	--Act
   	INSERT INTO TOURNAMENT
    VALUES   ('Schaakverening Horst', 'Toernooi 2018 Horst', 2, 'Gert', '2018-06-05 11:30:34', 
			  '2017-09-11 10:40:05', 10, 'Appellaan 2', '6738 TE', 'Arnhem', '2018-05-04 10:15:32')
END;